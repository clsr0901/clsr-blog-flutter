import 'package:blog/entity/blog/BlogResponse.dart';
import 'package:blog/entity/user/Userresponse.dart';
import 'package:blog/http/api.dart';
import 'package:blog/http/httpUtil.dart';
import 'package:blog/upload/upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zefyr/zefyr.dart';

class EditPage extends StatefulWidget {
  User _user;
  int _blogId;

  EditPage(this._user, this._blogId);

  @override
  State<StatefulWidget> createState() {
    return new EditPageState(_user, _blogId);
  }
}

class EditPageState extends State<EditPage> {
  User _user;
  int _blogId;

//  ZefyrController _controller;
//  FocusNode _focusNode;
  bool _edit = true;
  var _titleController = new TextEditingController();
  var _contentController = new TextEditingController();

  EditPageState(this._user, this._blogId);

  void showSaveDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => _shwoTitleDialog());
  }

  AlertDialog _shwoTitleDialog() {
    return new AlertDialog(
      title: new Text(
        "请输入标题",
        style: new TextStyle(
            color: Colors.red[300],
            fontWeight: FontWeight.w600,
            fontSize: 24.0),
      ),
      content: new TextField(
        style: new TextStyle(
            color: Theme.of(context).primaryColorLight, fontSize: 15.0),
        controller: _titleController,
        autofocus: false,
        decoration: new InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          labelText: "标题",
          prefixIcon: new Icon(
            Icons.title,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            '再想想',
            style: new TextStyle(color: Theme.of(context).primaryColorDark),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            '决定了',
            style: new TextStyle(color: Theme.of(context).primaryColorLight),
          ),
          onPressed: () {
            _save();
          },
        ),
      ],
    );
  }

  void _save() {
    HttpUtil.getInstance()
        .put(Api.PUTBLOG,
            data: new Blog(_blogId, _user.id, _titleController.text,
                _contentController.text))
        .then((response) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "保存成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.green[300],
          textColor: Colors.white);
      Navigator.of(context).pop();
    }).catchError((e) {
    });
  }

  @override
  void initState() {
    super.initState();
    // Create an empty document or load existing if you have one.
    // Here we create an empty document:
//    final document = new NotusDocument();
//    _controller = new ZefyrController(document);
//    _focusNode = new FocusNode();
    if (_blogId > 0) {
      HttpUtil.getInstance()
          .get(Api.GETBLOG + _blogId.toString())
          .then((response) {
        var blogVoResponse = BlogVOResponse.fromJson(response);
        setState(() {
//          _controller.document.insert(0, blogVoResponse.data.content);
          _contentController.value =
              TextEditingValue(text: blogVoResponse.data.content);
          _titleController.value =
              TextEditingValue(text: blogVoResponse.data.title);
        });
      }).catchError((e) {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white70,
        title: new Text(
          "编辑",
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColorLight,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                _edit ? Icons.visibility : Icons.edit,
                color: _edit
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                setState(() {
                  _edit = !_edit;
                });
              }),
          new IconButton(
              icon: new Icon(
                Icons.file_upload ,
                color:Colors.yellow[300],
              ),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new UploadPage(_user)));
              }),
          new IconButton(
              icon: new Icon(
                Icons.save,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                if (_contentController.text.length < 5) {
                  Fluttertoast.showToast(
                      msg: "请先输入内容",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.yellow[300],
                      textColor: Colors.white);
                } else {
                  showSaveDialog(context);
                }
              })
        ],
        centerTitle: true,
      ),
      body: _edit
          ? new Padding(
              child: new TextField(
                controller: _contentController,
                maxLines: 10000000,
              ),
              padding: EdgeInsets.only(left: 16.0, right: 16.0))
//      ZefyrScaffold(
//              child: ZefyrEditor(
//                controller: _controller,
//                focusNode: _focusNode,
//              ),
//            )
          : new Markdown(data: _contentController.text),
    );
  }
}
