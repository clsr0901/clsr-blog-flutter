import 'package:blog/entity/source/SourceResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';

class ImagePage extends StatelessWidget {
  Source source;

  ImagePage(this.source);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white70,
        title: new GestureDetector(
          child: new Text(
            "预览",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          onTap: () {},
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
        width: double.infinity,
        height: double.infinity,
        child: Image(
          image: AdvancedNetworkImage(source.url, useDiskCache: true),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
