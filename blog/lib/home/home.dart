import 'package:blog/entity/user/Userresponse.dart';
import 'package:blog/home/blogListView.dart';
import 'package:blog/http/api.dart';
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

class HomePageState extends State<HomePage> {
  final User user;
  BlogListView _blogListView;

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
        backgroundColor: Colors.white70,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: new CircleAvatar(
                backgroundImage: new NetworkImage(Api.BASE_URL + user.avatar),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        // 左侧返回按钮，可以有按钮，可以有文字
        title: new GestureDetector(
          child: Image.asset("images/logo.png"),
          onTap: () {
            setState(() {
              if (_blogListView != null) _blogListView.toTop();
            });
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.file_upload,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: null),
          new IconButton(
              icon: new Icon(
                Icons.edit,
                color: Theme.of(context).accentColor,
              ),
              onPressed: null)
        ],
      ),
      body: getListView(),
    );
  }

  BlogListView getListView() {
    if (_blogListView == null) _blogListView = new BlogListView();
    return _blogListView;
  }
}
