import 'package:json_annotation/json_annotation.dart';

// Userresponse.g.dart 将在我们运行生成命令后自动生成
part 'CommentResponse.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class CommentResponse extends Object {
  String msg;
  List<CommentVO> data;


  CommentResponse(this.msg, this.data); //不同的类使用不同的mixin即可
  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}

@JsonSerializable()
class CommentVOResponse extends Object {
  String msg;
  CommentVO data;


  CommentVOResponse(this.msg, this.data); //不同的类使用不同的mixin即可
  factory CommentVOResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentVOResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentVOResponseToJson(this);
}

@JsonSerializable()
class CommentVO extends Object {
  int id;
  int blogId;
  int destUserId;
  String destUserName;
  int sourceUserId;
  String sourceUserName;
  String content;
  int action;
  String createtime;
  bool showReply = false;


  CommentVO(this.id, this.blogId, this.destUserId, this.destUserName,
      this.sourceUserId, this.sourceUserName, this.content, this.action,
      this.createtime);

  //不同的类使用不同的mixin即可
  factory CommentVO.fromJson(Map<String, dynamic> json) =>
      _$CommentVOFromJson(json);

  Map<String, dynamic> toJson() => _$CommentVOToJson(this);
}

@JsonSerializable()
class Comment extends Object {
  int id;
  int blogId;
  int destUserId;
  int sourceUserId;
  String content;
  int action;
  String createtime;


  Comment();
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}