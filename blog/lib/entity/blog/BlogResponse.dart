import 'package:blog/entity/user/Userresponse.dart';
import 'package:json_annotation/json_annotation.dart';


///这个标注是告诉生成器，这个类是需要生成Model类的
part 'BlogResponse.g.dart';

@JsonSerializable()
class BlogResponse extends Object {
  String msg;
  List<BlogVO> data;

  BlogResponse(this.msg, this.data);

  //不同的类使用不同的mixin即可
  factory BlogResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlogResponseToJson(this);
}

@JsonSerializable()
class BlogVOResponse extends Object {
  String msg;
  BlogVO data;

  BlogVOResponse(this.msg, this.data);

  //不同的类使用不同的mixin即可
  factory BlogVOResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogVOResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlogVOResponseToJson(this);
}

@JsonSerializable()
class BlogVO extends Object {
  int id;
  User user;
  String title;
  String content;
  String summary;
  int hit;
  int view;
  int comments;
  bool sticky;
  bool highlight;
  String createtime;
  String updatetime;

  BlogVO(
      this.id,
      this.user,
      this.title,
      this.content,
      this.summary,
      this.hit,
      this.view,
      this.comments,
      this.sticky,
      this.highlight,
      this.createtime,
      this.updatetime);


  factory BlogVO.fromJson(Map<String, dynamic> json) => _$BlogVOFromJson(json);

  Map<String, dynamic> toJson() => _$BlogVOToJson(this);
}

@JsonSerializable()
class Blog extends Object {
  int id;

  int userId;

  String title;

  String content;

  String summary;

  int hit;

  int view;

  bool sticky;

  bool highlight;
  String createtime;

  String updatetime;

  Blog(this.id, this.userId, this.title, this.content);

  factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);

  Map<String, dynamic> toJson() => _$BlogToJson(this);


}
