import 'dart:async';

import 'package:blog/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Image.asset('images/lunch.png', fit: BoxFit.fill),
    );
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (Void) {
      /**
       * pushAndRemoveUntil 跳转并销毁当前页面
       * 包含三个参数，第一个小菜理解为上下文环境，
       * 第二个参数为静态注册的对应的页面名称，
       * 第三个参数为跳转后的操作，route == null 为销毁当前页面
       */
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (BuildContext context) => new LoginPage()),
          (Route route) => route == null);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
