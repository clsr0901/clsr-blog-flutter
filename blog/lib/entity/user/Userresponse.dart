import 'package:json_annotation/json_annotation.dart';

// Userresponse.g.dart 将在我们运行生成命令后自动生成
part 'Userresponse.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class UserResponse extends Object {
  String msg;
  User data;
  String token;

  UserResponse(this.msg, this.data, this.token);

  //不同的类使用不同的mixin即可
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
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

@JsonSerializable()
class UserVOResponse extends Object {
  String msg;
  UserVO data;

  UserVOResponse(this.msg, this.data);

  //不同的类使用不同的mixin即可
  factory UserVOResponse.fromJson(Map<String, dynamic> json) =>
      _$UserVOResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOResponseToJson(this);
}

@JsonSerializable()
class UserVO extends Object {
  int id;
  String username;
  String avatar;
  String email;
  String phone;
  String instruction;
  String createtime;
  int blogs;
  int comments;

  UserVO(
      this.id,
      this.username,
      this.avatar,
      this.email,
      this.phone,
      this.instruction,
      this.createtime,
      this.blogs,
      this.comments); //不同的类使用不同的mixin即可
  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
