import 'package:blog/detail/detail.dart';
import 'package:blog/entity/blog/BlogResponse.dart';
import 'package:blog/entity/user/Userresponse.dart';
import 'package:blog/http/api.dart';
import 'package:blog/http/httpUtil.dart';
import 'package:blog/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogListView extends StatefulWidget {
  User _user;
  BlogListViewState _blogListViewState;

  BlogListView(this._user);

  void toTop() {
    if (_blogListViewState != null) _blogListViewState.toTop();
  }

  BlogListViewState getBlogListViewState() {
    _blogListViewState = new BlogListViewState(_user);
    return _blogListViewState;
  }

  @override
  State<StatefulWidget> createState() {
    return getBlogListViewState();
  }
}

class BlogListViewState extends State<BlogListView> {
  User _user;
  List<BlogVO> _blogs = <BlogVO>[];
  bool _noMore = false;
  int _pageNum = 1;
  int _pageSize = 10;
  String _keyword = "";
  var _scrollController = new ScrollController();

  BlogListViewState(this._user);

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(child: listView(), onRefresh: _refresh);
  }

  @override
  void initState() {
    super.initState();
    _getBlobs();
  }

  Future<void> _refresh() async {
    _pageNum = 1;
    _getBlobs();
  }

  void toTop() {
    _scrollController.animateTo(0,
        duration: new Duration(milliseconds: 500), curve: Curves.ease);
  }

  void _getBlobs() {
    HttpUtil.getInstance().post(Api.GETBLOGS, data: {
      "keyword": _keyword,
      "pageNum": _pageNum,
      "pageSize": _pageSize
    }).then((response) {
      var blogResponse = BlogResponse.fromJson(response);
      setState(() {
        if (blogResponse.data.length == 0) {
          _noMore = true;
          _pageNum--;
        } else {
          _noMore = false;
          if (_pageNum == 1) {
            _blogs.clear();
          }
          _blogs.addAll(blogResponse.data);
        }
      });
    }, onError: (e) {
    });
  }

  Widget listView() => ListView.separated(
        controller: _scrollController,
        itemCount: _blogs.length + 1,
        itemBuilder: (context, index) {
          //如果到了表尾
          if (index == _blogs.length) {
            //不足100条，继续获取数据
            if (!_noMore) {
              //获取数据
              _pageNum++;
              _getBlobs();
              //加载时显示loading
              return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0)),
              );
            } else {
              //已经加载了100条数据，不再获取数据。
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "没有更多了",
                    style: TextStyle(color: Colors.grey),
                  ));
            }
          }
          return getItem(_blogs[index]);
        },
        separatorBuilder: (context, index) => Divider(height: .0),
      );

  getItem(BlogVO blog) {
    var colum = Container(
      margin: EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          new Container(
            width: double.infinity,
            child: new Text(
              blog.title,
              style: new TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          new Container(
            width: double.infinity,
            child: new Text(
              "    " + blog.summary,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: new TextStyle(
                inherit: false,
                color: Colors.black38,
                fontSize: 14.0,
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              new Container(
                child: new CircleAvatar(
                  backgroundImage:
                      new NetworkImage(Api.BASE_URL + blog.user.avatar),
                ),
                width: 24.0,
                height: 24.0,
                margin: EdgeInsets.only(right: 5.0),
              ),
              new Text(
                blog.user.username,
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
                blog.createtime,
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
                text: blog.view.toString(),
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
              new Text.rich(new TextSpan(
                text: blog.comments.toString(),
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
        ],
      ),
    );
    return new GestureDetector(
      child: new Card(
        child: colum,
      ),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new DetailPage(blog.id, _user)));
      },
    );
  }
}
