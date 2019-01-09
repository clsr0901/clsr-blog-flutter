import 'package:json_annotation/json_annotation.dart';

// Userresponse.g.dart 将在我们运行生成命令后自动生成
part 'Userresponse.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Userresponse extends Object {
  String msg;
  User data;
  String token;

  Userresponse(this.msg, this.data, this.token);

  //不同的类使用不同的mixin即可
  factory Userresponse.fromJson(Map<String, dynamic> json) =>
      _$UserresponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserresponseToJson(this);
}

@JsonSerializable()
class User extends Object {
  int id;

  String username;

  String avatar;

  String email;

  String phone;

  String instruction;

  String createtime;

  int blogs;

  int comments;

  User(this.id, this.username, this.avatar, this.email, this.phone,
      this.instruction, this.createtime, this.blogs, this.comments);

  //不同的类使用不同的mixin即可
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
