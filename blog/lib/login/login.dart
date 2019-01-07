import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  var hintTips = new TextStyle(color: Colors.black26, fontSize: 15.0);
  var _usernameController = new TextEditingController();
  var _passwordController = new TextEditingController();
  double leftRightPadding = 50.0;
  double topBottomPadding = 0.0;
  bool _show = true;

  void login(){

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Clsr",
          style:
              new TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          new Image.asset('images/lunch.png'),
          new Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.fromLTRB(leftRightPadding,
                      topBottomPadding, leftRightPadding, topBottomPadding),
                  child: new TextField(
                    style: hintTips,
                    controller: _usernameController,
                    autofocus: false,
                    decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      helperText: "请输入你的密码",
                      labelText: "请输入你的用户名",
                      icon: new Icon(
                        Icons.account_box,
                        color: Theme.of(context).primaryColor,
                      ),
                      suffix: new IconButton(
                        icon: new Icon(Icons.print, color: Colors.white,))
                    ),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(leftRightPadding,
                      topBottomPadding, leftRightPadding, topBottomPadding),
                  child: new TextField(
                    style: hintTips,
                    controller: _passwordController,
                    autofocus: false,
                    obscureText: _show,
                    decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      labelText: "请输入密码",
//                      helperText: "",
                      icon: new Icon(
                        Icons.lock,
                        color: Colors.blueGrey,
                      ),
                      suffix: new IconButton(
                        icon: new Icon(
                          _show ? Icons.visibility : Icons.visibility_off,
                          color: _show
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                        onPressed:(){
                          setState(() {
                            _show = !_show;
                          });

                        },
                      ),
                    ),
                  ),
                ),
                new Container(
                  width: 360.0,
                  margin: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  padding: new EdgeInsets.fromLTRB(leftRightPadding,
                      topBottomPadding, leftRightPadding, topBottomPadding),
                  child: new Card(
                    color: Color.fromARGB(255, 0, 215, 198),
                    elevation: 6.0,
                    child: new FlatButton(
                        onPressed: () {
                          login();
                        },
                        child: new Padding(
                          padding: new EdgeInsets.all(10.0),
                          child: new Text(
                            '登录',
                            style: new TextStyle(
                                color: Colors.white, fontSize: 16.0),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
