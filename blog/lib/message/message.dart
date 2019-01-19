import 'package:blog/entity/message/MessageResponse.dart';
import 'package:blog/entity/user/Userresponse.dart';
import 'package:blog/http/api.dart';
import 'package:blog/http/httpUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MessagePage extends StatefulWidget {
  int _userId;//用户中心用户id
  User _user;//登陆用户

  MessagePage(this._userId, this._user);

  @override
  State<StatefulWidget> createState() {
    return new MessagePageState(_userId, this._user);
  }
}

class MessagePageState extends State<MessagePage> {
  int _userId;
  User _user;
  List<MessageVO> _messages = <MessageVO>[];
  var _scrollController = new ScrollController();
  var _messageController = new TextEditingController();

  MessagePageState(this._userId, this._user);

  @override
  void initState() {
    super.initState();
    _getMessages();
  }

  void _getMessages() {
    HttpUtil.getInstance().get(Api.GETMESSAGE + _userId.toString()).then((res) {
      var messageResponse = MessageResponse.fromJson(res);
      setState(() {
        _messages.clear();
        _messages.addAll(messageResponse.data);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _refresh() async {
    _getMessages();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white70,
        title: new Text(
          "留言",
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
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.add,
                color: Theme.of(context).primaryColorLight,
              ),
              onPressed: () {
                showMessageDialog(context);
              })
        ],
      ),
      body: new RefreshIndicator(child: listView(), onRefresh: _refresh),
    );
  }

  Widget listView() => ListView.separated(
        controller: _scrollController,
        itemCount: _messages.length + 1,
        itemBuilder: (context, index) {
          //如果到了表尾
          if (index == _messages.length) {
            //不足100条，继续获取数据
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ));
          }
          return getItem(_messages[index]);
        },
        separatorBuilder: (context, index) => Divider(height: .0),
      );

  Widget getItem(MessageVO message) {
    if (message.showReply == null) message.showReply = false;
    var colum = Container(
      margin: EdgeInsets.all(4.0),
      child: new Column(
        children: <Widget>[
          new Container(
            width: double.infinity,
            child: Text.rich(new TextSpan(children: <TextSpan>[
              new TextSpan(
                text: message.sourceUserName,
                style: new TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0),
              ),
              new TextSpan(
                  text: " 留言说 ",
                  style: new TextStyle(color: Colors.black38, fontSize: 12.0)),
            ])),
            decoration: new BoxDecoration(
              color: Colors.grey[300],
            ),
            padding: EdgeInsets.all(5.0),
          ),
          new Container(
            width: double.infinity,
            child: new Text(
              "        " + message.message,
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
                message.createtime,
                style: new TextStyle(color: Colors.grey[500], fontSize: 12.0),
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
                  showDeleteDialog(context, message);
                },
              ),
            ],
          ),
        ],
      ),
    );
    return colum;
  }

  void showDeleteDialog(BuildContext context, MessageVO message) {
    showDialog(context: context, builder: (_) => _shwoDeleteDialog(message));
  }

  AlertDialog _shwoDeleteDialog(MessageVO message) {
    return new AlertDialog(
      title: new Text(
        "删除！",
        style: new TextStyle(
            color: Colors.red[300],
            fontWeight: FontWeight.w600,
            fontSize: 24.0),
      ),
      content: new Text("确定删除这条留言？",
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
            _delete(message);
          },
        ),
      ],
    );
  }

  void _delete(MessageVO message) {
    HttpUtil.getInstance()
        .delete(Api.DELETEMESSAGE + message.id.toString())
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
        _messages.remove(message);
      });
    }).catchError((e) {
      print(e);
    });
  }

  void showMessageDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => _shwoMessageDialog());
  }

  AlertDialog _shwoMessageDialog() {
    return new AlertDialog(
      title: new Text(
        "给他留言",
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
          controller: _messageController,
          style: new TextStyle(color: Colors.blue[300], fontSize: 14.0),
          decoration: new InputDecoration(
              hintText: "请输入留言内容",
              hintStyle: new TextStyle(
                  color: Theme.of(context).primaryColorLight, fontSize: 12.0),
              border: InputBorder.none),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            '我在想想',
            style: new TextStyle(color: Theme.of(context).primaryColorDark),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            '给他留言',
            style: new TextStyle(color: Theme.of(context).primaryColorLight),
          ),
          onPressed: () {
            _message();
          },
        ),
      ],
    );
  }

  void _message() {
    if (_messageController.text.length == 0) {
      Fluttertoast.showToast(
          msg: "请先输入留言内容",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.yellow[300],
          textColor: Colors.white);
      return;
    }
    Message message = new Message();
    message.sourceUserId = _user.id;
    message.message = _messageController.text;
    message.destUserId = _userId;
    HttpUtil.getInstance().put(Api.PUTMESSAGE, data: message).then((res) {
      var messageResponse = MessageVOResponse.fromJson(res);
      setState(() {
        _messageController.text = "";
        _messages.insert(0, messageResponse.data);
      });
      Navigator.of(context).pop();
    }, onError: (e) {
      print(e);
    });
  }
}
