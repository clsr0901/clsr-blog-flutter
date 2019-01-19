import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  int _userId;

  MessagePage(this._userId);

  @override
  State<StatefulWidget> createState() {
    return new MessagePageState(_userId);
  }
}

class MessagePageState extends State<MessagePage> {
  int _userId;

  MessagePageState(this._userId);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white70,
        title: new Text(
          "留言",
          style: TextStyle(
            color: Theme
                .of(context)
                .primaryColorLight,
          ),
        ),
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Theme
                  .of(context)
                  .primaryColorLight,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
      ),
    );
  }
}