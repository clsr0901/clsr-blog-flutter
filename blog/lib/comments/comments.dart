import 'package:blog/entity/comment/CommentResponse.dart';
import 'package:blog/entity/user/Userresponse.dart';
import 'package:blog/http/api.dart';
import 'package:blog/http/httpUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentsPage extends StatefulWidget {
  int _blogId;
  User _user;

  CommentsPage(this._blogId, this._user);

  @override
  State<StatefulWidget> createState() {
    return new CommentsPageState(_blogId, _user);
  }
}

class CommentsPageState extends State<CommentsPage> {
  int _blogId;
  User _user;
  List<CommentVO> _commets = <CommentVO>[];
  var _scrollController = new ScrollController();
  var _replyController = new TextEditingController();
  var _commentController = new TextEditingController();
  CommentVO _selectComment;

  CommentsPageState(this._blogId, this._user);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCommets();
  }

  void _getCommets() {
    HttpUtil.getInstance()
        .get(Api.GETCOMMENTS + _blogId.toString())
        .then((res) {
      print(res);
      var commentsResponse = CommentResponse.fromJson(res);
      setState(() {
        _commets.clear();
        _commets.addAll(commentsResponse.data);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _refresh() async {
    _getCommets();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white70,
        title: new GestureDetector(
          child: new Text(
            "评论",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          onTap: (){
            _scrollController.animateTo(0,
                duration: new Duration(milliseconds: 500), curve: Curves.ease);
          },
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
          new IconButton(
              icon: new Icon(
                Icons.add,
                color: Theme.of(context).primaryColorLight,
              ),
              onPressed: () {
                showCommentDialog(context);
              })
        ],
      ),
      body: new RefreshIndicator(child: listView(), onRefresh: _refresh),
    );
  }

  Widget listView() => ListView.separated(
        controller: _scrollController,
        itemCount: _commets.length + 1,
        itemBuilder: (context, index) {
          //如果到了表尾
          if (index == _commets.length) {
            //不足100条，继续获取数据
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ));
          }
          return getItem(_commets[index]);
        },
        separatorBuilder: (context, index) => Divider(height: .0),
      );

  Widget getItem(CommentVO comment) {
    if (comment.showReply == null) comment.showReply = false;
    var colum = Container(
      margin: EdgeInsets.all(4.0),
      child: new Column(
        children: <Widget>[
          new Container(
            width: double.infinity,
            child: comment.action == 0
                ? Text.rich(new TextSpan(children: <TextSpan>[
                    new TextSpan(
                      text: comment.sourceUserName,
                      style: new TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                    new TextSpan(
                        text: " 评论了您的博客 :",
                        style: new TextStyle(
                            color: Colors.black38, fontSize: 12.0))
                  ]))
                : Text.rich(new TextSpan(children: <TextSpan>[
                    new TextSpan(
                      text: comment.sourceUserName,
                      style: new TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                    new TextSpan(
                        text: " 回复 ",
                        style: new TextStyle(
                            color: Colors.black38, fontSize: 12.0)),
                    new TextSpan(
                      text: comment.destUserName,
                      style: new TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                    new TextSpan(
                        text: " 说 :",
                        style: new TextStyle(
                            color: Colors.black38, fontSize: 12.0)),
                  ])),
            decoration: new BoxDecoration(
              color: Colors.grey[300],
            ),
            padding: EdgeInsets.all(5.0),
          ),
          new Container(
            width: double.infinity,
            child: new Text(
              "        " + comment.content,
              style: new TextStyle(color: Colors.black26, fontSize: 12.0),
            ),
          ),
          new Divider(
            height: 1.0,
            color: Colors.grey[300],
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(""),
                flex: 1,
              ),
              new Text(
                comment.createtime,
                style: new TextStyle(color: Colors.grey[500], fontSize: 12.0),
              ),
              new GestureDetector(
                child: new Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: new Icon(
                    Icons.markunread,
                    color: Theme.of(context).primaryColorLight,
                    size: 16.0,
                  ),
                ),
                onTap: () {
                  setState(() {
                    if (_selectComment != null) {
                      if (_selectComment.id != comment.id) {
                        _replyController.text = "";
                        _selectComment.showReply = false;
                        comment.showReply = true;
                      } else {
                        comment.showReply = !comment.showReply;
                      }
                    } else {
                      comment.showReply = !comment.showReply;
                    }
                    _selectComment = comment;
                  });
                },
              ),
              new GestureDetector(
                child: new Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: new Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).primaryColorDark,
                    size: 16.0,
                  ),
                ),
                onTap: () {
                  showDeleteDialog(context, comment);
                },
              ),
            ],
          ),
          new Container(
            child: comment.showReply
                ? new Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                    child: new Column(
                      children: <Widget>[
                        new TextField(
                          maxLines: 5,
                          maxLength: 255,
                          controller: _replyController,
                          style: new TextStyle(
                              color: Colors.blue[300], fontSize: 14.0),
                          decoration: new InputDecoration(
                              hintText: "请输入回复内容",
                              hintStyle: new TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontSize: 12.0),
                              border: InputBorder.none),
                        ),
                        new Container(
                            height: 24.0,
                            width: double.infinity,
                            child: new FlatButton(
                              onPressed: () {
                                _reply(comment);
                              },
                              color: Colors.blue,
                              child: new Text(
                                '回复',
                                style: new TextStyle(
                                    color: Colors.white70, fontSize: 12.0),
                              ),
                            ))
                      ],
                    ),
                  )
                : new Divider(
                    height: 0.0,
                  ),
          )
        ],
      ),
    );
    return colum;
  }

  void showDeleteDialog(BuildContext context, CommentVO comment) {
    showDialog(context: context, builder: (_) => _shwoDeleteDialog(comment));
  }

  AlertDialog _shwoDeleteDialog(CommentVO comment) {
    return new AlertDialog(
      title: new Text(
        "删除！",
        style: new TextStyle(
            color: Colors.red[300],
            fontWeight: FontWeight.w600,
            fontSize: 24.0),
      ),
//      content: new Text("确定删除【" + _blogVO.title + "】?"),
      content: new Text("确定删除这条评论？",
          style: new TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.red[500])),
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
            _delete(comment);
          },
        ),
      ],
    );
  }

  void _delete(CommentVO comment) {
    HttpUtil.getInstance()
        .delete(Api.DELETCOMMENT + comment.id.toString())
        .then((res) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "删除成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.green[300],
          textColor: Colors.white);
      setState(() {
        _commets.remove(comment);
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _reply(CommentVO commentVO) {
    if (_replyController.text.length == 0) {
      Fluttertoast.showToast(
          msg: "请先输入回复内容",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.yellow[300],
          textColor: Colors.white);
      return;
    }
    Comment comment = new Comment();
    comment.action = 1;
    comment.blogId = _blogId;
    comment.content = _replyController.text;
    comment.destUserId = commentVO.sourceUserId;
    comment.sourceUserId = _user.id;
    HttpUtil.getInstance().put(Api.PUTCOMMENTS, data: comment).then((res) {
      var commentResponse = CommentVOResponse.fromJson(res);
      setState(() {
        _selectComment.showReply = false;
        _replyController.text = "";
        _commets.insert(0, commentResponse.data);
      });
    }, onError: (e) {
      print(e);
    });
  }

  void showCommentDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => _shwoCommentDialog());
  }

  AlertDialog _shwoCommentDialog() {
    return new AlertDialog(
      title: new Text(
        "添加评论",
        style: new TextStyle(
            color: Colors.blue[300],
            fontWeight: FontWeight.w600,
            fontSize: 20.0),
      ),
//      content: new Text("确定删除【" + _blogVO.title + "】?"),
      content: new Container(
        padding: EdgeInsets.all(5.0),
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
        ),
        child: new TextField(
          maxLines: 5,
          maxLength: 255,
          controller: _commentController,
          style: new TextStyle(color: Colors.blue[300], fontSize: 14.0),
          decoration: new InputDecoration(
              hintText: "请输入评论内容",
              hintStyle: new TextStyle(
                  color: Theme.of(context).primaryColorLight, fontSize: 12.0),
              border: InputBorder.none),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            '再看看',
            style: new TextStyle(color: Theme.of(context).primaryColorDark),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            '评论它',
            style: new TextStyle(color: Theme.of(context).primaryColorLight),
          ),
          onPressed: () {
            _comment();
          },
        ),
      ],
    );
  }

  void _comment() {
    if (_commentController.text.length == 0) {
      Fluttertoast.showToast(
          msg: "请先输入评论内容",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.yellow[300],
          textColor: Colors.white);
      return;
    }
    Comment comment = new Comment();
    comment.action = 0;
    comment.blogId = _blogId;
    comment.content = _commentController.text;
    comment.sourceUserId = _user.id;
    HttpUtil.getInstance().put(Api.PUTCOMMENTS, data: comment).then((res) {
      var commentResponse = CommentVOResponse.fromJson(res);
      setState(() {
        _commentController.text = "";
        _commets.insert(0, commentResponse.data);
      });
      Navigator.of(context).pop();
    }, onError: (e) {
      print(e);
    });
  }
}
