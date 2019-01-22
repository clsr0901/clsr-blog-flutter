import 'package:blog/entity/source/SourceResponse.dart';
import 'package:blog/entity/user/Userresponse.dart';
import 'package:blog/http/api.dart';
import 'package:blog/http/httpUtil.dart';
import 'package:blog/preview/image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class UploadPage extends StatefulWidget {
  User _user;

  UploadPage(this._user);

  @override
  State<StatefulWidget> createState() {
    return new UploadPageState(_user);
  }
}

class UploadPageState extends State<UploadPage> {
  User _user;
  List<Source> _sources = <Source>[];
  Source selectSource;
  static final int CHUNKSIZE = 2 * 1024 ;

  UploadPageState(this._user);

  void getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      if (filePath == '') {
        return;
      }
      File file = new File(filePath);
      int index = filePath.lastIndexOf("/");
      var fileName = filePath.substring(index + 1);
      if (!await file.exists()) {
        Fluttertoast.showToast(
            msg: "文件不存在",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIos: 1,
            backgroundColor: Colors.red[300],
            textColor: Colors.white);
        return;
      }
      file.length().then((length) {
        return new Future(() => length);
      }).then((length) {
        List<int> fileAllContent = new List();
        file.openRead().listen((List<int> data) {
          fileAllContent.addAll(data);
        }, onDone: () {
          var md5Str = hex.encode(md5.convert(fileAllContent).bytes);
          //分段上传
          sliceUpload(file, fileName, md5Str);
        });
      }, onError: (e) {
        print(e);
      });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }


  //分片上传
  void sliceUpload(File file, String fileName, String md5Str) {
    file.length().then((length) {
      return new Future(() => length);
    }).then((length) {
      String chunkStr = ((length - length % CHUNKSIZE) / CHUNKSIZE).toString();
      int index = chunkStr.indexOf(".");
      int chunks = int.parse(chunkStr.substring(0, index));
      if (length % CHUNKSIZE > 0) chunks++;
      upload(file, md5Str, 0, chunks, length, fileName);
    }, onError: (e) {
      print(e);
    });
  }

  void upload(final File file, final String md5Str, final int chunk,
      final int chunks, final int fileSize, final String fileName) {
    int start = chunk * CHUNKSIZE;
    int end = start + CHUNKSIZE;
    if (fileSize < end) {
      end = fileSize;
    }
    if (start > fileSize) {
      int index = fileName.indexOf(".");
      FormData formData = new FormData.from({
        "md5": md5Str,
        "ext": fileName.substring(index + 1),
        "fileName": fileName,
      });
      HttpUtil.getInstance().post(Api.UPLOADMERGE, data: formData).then((res) {
        var sourceResponse = SourceResponse.fromJson(res);
        setState(() {
          _sources.insert(0, sourceResponse.data);
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      File tempFile = new File("/sdcard/Download/temp");
      List<int> fileInt = new List();
      file.openRead().listen((List<int> data) {
        fileInt.addAll(data);
      }, onDone: () {
        tempFile.writeAsBytes(fileInt).then((destFile) {
          FormData formData = new FormData.from({
            "chunk": chunk,
            "chunks": chunks,
            "file": new UploadFileInfo(destFile, fileName),
            "md5": md5Str,
            "ext": "image/jpg",
          });
          return HttpUtil.getInstance().post(Api.UPLOADCHUNK, data: formData);
        }).then((res) {
          upload(file, md5Str, chunk + 1, chunks, fileSize, fileName);
        }).catchError((e) {
          print(e);
        });
      });
    }
  }

  void download(Source source) {
    HttpUtil.getInstance()
        .download(
            source.url, "/sdcard/Download/" + source.name, setDownloadProgress)
        .then((res) {
      Fluttertoast.showToast(
          msg: "/sdcard/Download/" + source.name + "保存成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.green[300],
          textColor: Colors.white);
      setState(() {
        selectSource.download = false;
      });
    }).catchError((e) {
      print(e);
    });
  }

  void setDownloadProgress(double percent) {
    setState(() {
      selectSource.percent = percent;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSources();
  }

  Future<void> _refresh() async {
    _getSources();
  }

  void _getSources() {
    HttpUtil.getInstance().get(Api.GETSOURCE + _user.id.toString()).then((res) {
      var sourcesResponse = SourcesResponse.fromJson(res);
      _sources.clear();
      _sources.addAll(sourcesResponse.data);
      _sources.add(null);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white70,
        title: new GestureDetector(
          child: new Text(
            "资源管理",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          onTap: () {},
        ),
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColorLight,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
      ),
      body: new RefreshIndicator(
          child: GridView.count(
            crossAxisCount: 3,
            padding: EdgeInsets.all(10.0),
            children: _sources.map((Source source) {
              return _getGridViewItemUI(context, source);
            }).toList(),
          ),
          onRefresh: _refresh),
    );
  }

  Widget _getGridViewItemUI(BuildContext context, Source source) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 4.0,
        child: source == null
            ? new IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.grey[500],
                  size: 64.0,
                ),
                onPressed: getFilePath)
            : Column(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Container(
                        child: getImage(source),
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                    ),
                    flex: 4,
                  ),
                  new Expanded(
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new IconButton(
                              icon: new Icon(
                                Icons.visibility,
                                color: Theme.of(context).primaryColorLight,
                                size: 16.0,
                              ),
                              onPressed: () {
                                if (source.type == 1) {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new ImagePage(source)));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "程序员正在努力开发...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIos: 1,
                                      backgroundColor: Colors.green[300],
                                      textColor: Colors.white);
                                }
                              }),
                          flex: 1,
                        ),
                        new Expanded(
                          child: new IconButton(
                              icon: new Icon(
                                Icons.file_download,
                                color: Colors.yellow[500],
                                size: 16.0,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectSource == null) {
                                    selectSource = source;
                                    selectSource.download = true;
                                  } else {
                                    if (selectSource.id != source.id) {
                                      selectSource.download = false;
                                      selectSource = source;
                                      selectSource.download = true;
                                    }
                                  }
                                });
                                download(source);
                              }),
                          flex: 1,
                        ),
                        new Expanded(
                          child: new IconButton(
                              icon: new Icon(
                                Icons.delete_outline,
                                color: Theme.of(context).primaryColorDark,
                                size: 16.0,
                              ),
                              onPressed: () {
                                showDeleteDialog(context, source);
                              }),
                          flex: 1,
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                  (source != null && source.download != null && source.download)
                      ? new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Text(""),
                              flex: 1,
                            ),
                            new LinearPercentIndicator(
                              width: 100.0,
                              lineHeight: 8.0,
                              percent: source == null
                                  ? 0.0
                                  : source.percent == null
                                      ? 0.0
                                      : source.percent > 1.0
                                          ? 1.0
                                          : source.percent,
                              progressColor: Colors.blue,
                            ),
                            new Expanded(
                              child: new Text(""),
                              flex: 1,
                            ),
                          ],
                        )
                      : new Text(""),
                ],
              ),
      ),
    );
  }

  Widget getImage(Source source) {
    if (source.type == 0) {
      return new Icon(Icons.text_format, color: Colors.grey[500], size: 48.0);
    } else if (source.type == 1) {
      return Image(
        image: AdvancedNetworkImage(source.url, useDiskCache: true),
        fit: BoxFit.cover,
      );
    } else if (source.type == 2) {
      return new Icon(Icons.audiotrack, color: Colors.red[300], size: 48.0);
    } else if (source.type == 3) {
      return new Icon(Icons.videocam, color: Colors.blue[300], size: 48.0);
    } else {
      return new Icon(Icons.insert_drive_file,
          color: Colors.yellow[300], size: 48.0);
    }
  }

  void showDeleteDialog(BuildContext context, Source source) {
    showDialog(context: context, builder: (_) => _shwoDeleteDialog(source));
  }

  AlertDialog _shwoDeleteDialog(Source source) {
    return new AlertDialog(
      title: new Text(
        "删除文件！",
        style: new TextStyle(
            color: Colors.red[300],
            fontWeight: FontWeight.w600,
            fontSize: 24.0),
      ),
      content: new Text("确定删除？",
          style: new TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.red[500])),
      actions: <Widget>[
        FlatButton(
          child: Text(
            '留着吧',
            style: new TextStyle(color: Theme.of(context).primaryColorDark),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            '不要了',
            style: new TextStyle(color: Theme.of(context).primaryColorLight),
          ),
          onPressed: () {
            _delete(source);
          },
        ),
      ],
    );
  }

  void _delete(Source source) {
    HttpUtil.getInstance().delete(Api.DELETESOURCE + source.uid).then((res) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "删除成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.green[300],
          textColor: Colors.white);
      setState(() {
        _sources.remove(source);
      });
    }).catchError((e) {
      print(e);
    });
  }
}
