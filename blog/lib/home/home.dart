import 'package:blog/entity/user/Userresponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User _user;

  HomePage(this._user);

  @override
  State<StatefulWidget> createState() {
    return new HomePageState(_user);
  }
  
}

class HomePageState extends State<HomePage>{
  final User user;

  HomePageState(this.user);
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("home主页");
    print(user.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("博客主页"),
      ),
      body: new Image.asset("images/lunch.png"),
    );
  }
  
}