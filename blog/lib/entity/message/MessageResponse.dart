import 'package:json_annotation/json_annotation.dart';

part 'MessageResponse.g.dart';

@JsonSerializable()
class MessageResponse extends Object {
  String msg;
  List<MessageVO> data;

  MessageResponse(this.msg, this.data);

  //不同的类使用不同的mixin即可
  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);
}

@JsonSerializable()
class MessageVOResponse extends Object {
  String msg;
  MessageVO data;

  MessageVOResponse(this.msg, this.data);

  //不同的类使用不同的mixin即可
  factory MessageVOResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageVOResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOResponseToJson(this);
}

@JsonSerializable()
class MessageVO extends Object {
  int id;
  String destUserName;
  String sourceUserName;
  String message;
  String createtime;
  bool showReply;


  MessageVO(this.id, this.destUserName, this.sourceUserName, this.message,
      this.createtime); //不同的类使用不同的mixin即可
  factory MessageVO.fromJson(Map<String, dynamic> json) =>
      _$MessageVOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOToJson(this);
}

@JsonSerializable()
class Message extends Object {
  int id;
  int destUserId;
  int sourceUserId;
  String message;
  String createtime;

  Message(); //不同的类使用不同的mixin即可

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}