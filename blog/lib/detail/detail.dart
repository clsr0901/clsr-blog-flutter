import 'package:blog/comments/comments.dart';
import 'package:blog/edit/edit.dart';
import 'package:blog/entity/blog/BlogResponse.dart';
import 'package:blog/entity/user/Userresponse.dart';
import 'package:blog/http/api.dart';
import 'package:blog/http/httpUtil.dart';
import 'package:blog/user/userInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailPage extends StatefulWidget {
  int _blogId;
  User _user;

  DetailPage(this._blogId, this._user);

  @override
  State<StatefulWidget> createState() {
    return new DetailPageState(_blogId, _user);
  }
}

class DetailPageState extends State<DetailPage> {
  BlogVO _blogVO;
  int _blogId;
  var _scrollController = new ScrollController();
  bool _showTitle = false;
  User _user;

  DetailPageState(this._blogId, this._user);

  void showDeleteDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => _shwoDeleteDialog());
  }

  AlertDialog _shwoDeleteDialog() {
    return new AlertDialog(
      title: new Text(
        "删除！",
        style: new TextStyle(
            color: Colors.red[300],
            fontWeight: FontWeight.w600,
            fontSize: 24.0),
      ),
//      content: new Text("确定删除【" + _blogVO.title + "】?"),
      content: new RichText(
        text: new TextSpan(
          text: '确定删除【',
          style:
              new TextStyle(inherit: true, fontSize: 18.0, color: Colors.blue),
          children: <TextSpan>[
            new TextSpan(
                text: _blogVO.title,
                style: new TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[500])),
            new TextSpan(
                text: '】?',
                style: new TextStyle(fontSize: 18.0, color: Colors.blue)),
          ],
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
            _delete();
          },
        ),
      ],
    );
  }

  void _delete() {
    HttpUtil.getInstance()
        .delete(Api.DELETEBLOG + _blogId.toString())
        .then((res) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "删除成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.green[300],
          textColor: Colors.white);
      Navigator.of(context).pop();
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset < 85 && _showTitle) {
        setState(() {
          _showTitle = false;
        });
      } else if (_scrollController.offset >= 85 && !_showTitle) {
        setState(() {
          _showTitle = true;
        });
      }
    });
    getBlogContent();
  }

  void getBlogContent() {
    HttpUtil.getInstance()
        .get(Api.GETBLOG + _blogId.toString())
        .then((response) {
      var blogVoResponse = BlogVOResponse.fromJson(response);
      setState(() {
        _blogVO = blogVoResponse.data;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _blogVO == null
        ? new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.white70,
              title: new Text(
                "详情",
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
              centerTitle: true,
            ),
            body: new GestureDetector(
              child: new Center(
                child: new Text(
                  "点击重新加载",
                  textAlign: TextAlign.center,
                  style:
                      new TextStyle(color: Theme.of(context).primaryColorDark),
                ),
              ),
              onTap: getBlogContent,
            ))
        : new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.white70,
              title: new Text(
                _showTitle ? _blogVO.title : "详情",
                style: TextStyle(
                    color: _showTitle
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).primaryColorLight,
                    fontSize: _showTitle ? 24.0 : 20.0,
                    fontWeight:
                        _showTitle ? FontWeight.w600 : FontWeight.normal),
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
              actions: <Widget>[
                new Center(
                    child: new IconButton(
                  icon: new CircleAvatar(
                    backgroundImage:
                        new NetworkImage(Api.BASE_URL + _blogVO.user.avatar),
                  ),
                  onPressed: null,
                )),
              ],
            ),
            body: new ListView(
              controller: _scrollController,
              children: <Widget>[
                new Card(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        child: new Text(
                          _blogVO.title,
                          style: new TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 16.0, top: 16.0),
                      ),
                      new Container(
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              child: new GestureDetector(
                                child: new CircleAvatar(
                                  backgroundImage: new NetworkImage(
                                      Api.BASE_URL + _blogVO.user.avatar),
                                ),
                                onTap: (){
                                  Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (BuildContext context) => new UserInfoPage(_blogVO.user.id)));
                                },
                              ),
                              width: 24.0,
                              height: 24.0,
                              margin: EdgeInsets.only(right: 5.0),
                            ),
                            new Text(
                              _blogVO.user.username,
                              style: new TextStyle(
                                color: Colors.black38,
                                fontSize: 12.0,
                              ),
                            ),
                            new Container(
                              margin: EdgeInsets.only(left: 5.0, right: 5.0),
                              width: 2.0,
                              height: 2.0,
                              child: new CircleAvatar(
                                backgroundColor: Colors.black38,
                              ),
                            ),
                            new Text(
                              _blogVO.createtime,
                              style: new TextStyle(
                                color: Colors.black38,
                                fontSize: 12.0,
                              ),
                            ),
                            new Expanded(
                              child: new Text(""),
                              flex: 1,
                            ),
                            new Text.rich(new TextSpan(
                              text: _blogVO.view.toString(),
                              style: new TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 12.0,
                              ),
                            )),
                            new Text(
                              " 阅读",
                              style: new TextStyle(
                                color: Colors.black38,
                                fontSize: 12.0,
                              ),
                            ),
                            new Container(
                              margin: EdgeInsets.only(left: 5.0, right: 5.0),
                              width: 2.0,
                              height: 2.0,
                              child: new CircleAvatar(
                                backgroundColor: Colors.black38,
                              ),
                            ),
                            new GestureDetector(
                              child: new Row(
                                children: <Widget>[
                                  new Text.rich(new TextSpan(
                                    text: _blogVO.comments.toString(),
                                    style: new TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 12.0,
                                    ),
                                  )),
                                  new Text(
                                    " 评论",
                                    style: new TextStyle(
                                      color: Colors.black38,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new CommentsPage(_blogId, _user)));
                              },
                            ),
                            new IconButton(
                              alignment: Alignment.centerRight,
                              icon: new Icon(
                                Icons.edit,
                                color: Theme.of(context).primaryColorLight,
                              ),
                              iconSize: 16.0,
                              onPressed: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new EditPage(_user, _blogId)));
                              },
                            ),
                            new IconButton(
                                alignment: Alignment.centerLeft,
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Theme.of(context).primaryColorDark,
                                  size: 16.0,
                                ),
                                onPressed: () {
                                  showDeleteDialog(context);
                                })
                          ],
                        ),
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 7.0),
                      )
                    ],
                  ),
                ),
                new Container(
                  child: new MarkdownBody(data: _blogVO.content),
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                )
              ],
            ));
  }
}
