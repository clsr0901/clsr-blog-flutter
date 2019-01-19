// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) {
  return MessageResponse(
      json['msg'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : MessageVO.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$MessageResponseToJson(MessageResponse instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': instance.data};

MessageVOResponse _$MessageVOResponseFromJson(Map<String, dynamic> json) {
  return MessageVOResponse(
      json['msg'] as String,
      json['data'] == null
          ? null
          : MessageVO.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$MessageVOResponseToJson(MessageVOResponse instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': instance.data};

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) {
  return MessageVO(
      json['id'] as int,
      json['destUserName'] as String,
      json['sourceUserName'] as String,
      json['message'] as String,
      json['createtime'] as String)
    ..showReply = json['showReply'] as bool;
}

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'id': instance.id,
      'destUserName': instance.destUserName,
      'sourceUserName': instance.sourceUserName,
      'message': instance.message,
      'createtime': instance.createtime,
      'showReply': instance.showReply
    };

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message()
    ..id = json['id'] as int
    ..destUserId = json['destUserId'] as int
    ..sourceUserId = json['sourceUserId'] as int
    ..message = json['message'] as String
    ..createtime = json['createtime'] as String;
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'destUserId': instance.destUserId,
      'sourceUserId': instance.sourceUserId,
      'message': instance.message,
      'createtime': instance.createtime
    };
