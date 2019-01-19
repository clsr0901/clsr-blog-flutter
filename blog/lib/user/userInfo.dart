import 'package:blog/entity/user/Userresponse.dart';
import 'package:blog/http/api.dart';
import 'package:blog/http/httpUtil.dart';
import 'package:blog/message/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  int _userId;

  UserInfoPage(this._userId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new UserInfoPageState(_userId);
  }
}

class UserInfoPageState extends State<UserInfoPage> {
  int _userId;
  UserVO _user;

  UserInfoPageState(this._userId);

  @override
  void initState() {
    super.initState();
    HttpUtil.getInstance().get(Api.GETUSER + _userId.toString()).then((res) {
      var userVOResponse = UserVOResponse.fromJson(res);
      setState(() {
        _user = userVOResponse.data;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white70,
        title: new Text(
          "用户中心",
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
      body: new Container(
        color: Colors.grey[300],
        child: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                border: new Border.all(width: 1.0, color: Colors.grey[200]),
                color: Colors.white70,
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
              ),
              margin: EdgeInsets.only(
                  top: 100.0, left: 50.0, right: 50.0, bottom: 50.0),
              padding: EdgeInsets.only(top: 55.0),
              child: new Container(
                width: double.infinity,
                height: double.infinity,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: new Text(
                        _user == null ? "0" : _user.username,
                        style: new TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    new Divider(
                      color: Colors.black38,
                      height: 1.0,
                    ),
                    new Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        children: <Widget>[
                          new Expanded(
                            child: new Column(
                              children: <Widget>[
                                new Text(
                                  "原创",
                                  style: new TextStyle(
                                      color: Colors.black38, fontSize: 12.0),
                                ),
                                new Text(
                                  _user == null ? "0" : _user.blogs.toString(),
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            flex: 1,
                          ),
                          new Expanded(
                            child: new Column(
                              children: <Widget>[
                                new Text(
                                  "粉丝",
                                  style: new TextStyle(
                                      color: Colors.black38, fontSize: 12.0),
                                ),
                                new Text(
                                  "0901",
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            flex: 1,
                          ),
                          new Expanded(
                            child: new Column(
                              children: <Widget>[
                                new Text(
                                  "喜欢",
                                  style: new TextStyle(
                                      color: Colors.black38, fontSize: 12.0),
                                ),
                                new Text(
                                  "0901",
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            flex: 1,
                          ),
                          new Expanded(
                            child: new Column(
                              children: <Widget>[
                                new Text(
                                  "评论",
                                  style: new TextStyle(
                                      color: Colors.black38, fontSize: 12.0),
                                ),
                                new Text(
                                  _user == null
                                      ? "0"
                                      : _user.comments.toString(),
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                    new Divider(
                      color: Colors.black38,
                      height: 1.0,
                    ),
                    new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new Icon(
                              Icons.phone,
                              color: Colors.green[300],
                              size: 20.0,
                            ),
                            flex: 1,
                          ),
                          new Expanded(
                            child: new Text(
                              _user.phone,
                              style: new TextStyle(
                                  color: Colors.black38, fontSize: 20.0),
                            ),
                            flex: 4,
                          ),
                        ],
                      ),
                    ),
                    new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new Icon(
                              Icons.alternate_email,
                              color: Colors.green[300],
                              size: 20.0,
                            ),
                            flex: 1,
                          ),
                          new Expanded(
                            child: new Text(
                              _user.email,
                              style: new TextStyle(
                                  color: Colors.black38, fontSize: 20.0),
                            ),
                            flex: 4,
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      width: double.infinity,
                      child: new Text(
                        "一句话描述自己:",
                        style: new TextStyle(
                            color: Colors.grey[500], fontSize: 12.0),
                      ),
                      padding: EdgeInsets.only(left: 20.0),
                    ),
                    new Expanded(
                      child: new Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        padding:
                            EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                        child: new Text(_user.instruction),
                        decoration: new BoxDecoration(
                          border: new Border.all(
                              width: 1.0, color: Colors.grey[200]),
                          color: Colors.white70,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(5.0)),
                        ),
                      ),
                      flex: 1,
                    ),
                    new Container(
                      width: double.infinity,
                      height: 30.0,
                      child: new FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MessagePage(_userId)));
                        },
                        child: new Text(
                          '查看留言',
                          style:
                              new TextStyle(color: Colors.cyan, fontSize: 10.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new Container(
                width: double.infinity,
                height: 100.0,
                child: new Center(
                  child: ClipOval(
                    child: new FadeInImage.assetNetwork(
                      placeholder: "images/normal_user_icon.webp",
                      //预览图
                      fit: BoxFit.fitWidth,
                      image: Api.BASE_URL + (_user == null ? "" : _user.avatar),
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
