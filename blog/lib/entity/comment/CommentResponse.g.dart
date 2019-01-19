// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommentResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) {
  return CommentResponse(
      json['msg'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : CommentVO.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': instance.data};

CommentVOResponse _$CommentVOResponseFromJson(Map<String, dynamic> json) {
  return CommentVOResponse(
      json['msg'] as String,
      json['data'] == null
          ? null
          : CommentVO.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CommentVOResponseToJson(CommentVOResponse instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': instance.data};

CommentVO _$CommentVOFromJson(Map<String, dynamic> json) {
  return CommentVO(
      json['id'] as int,
      json['blogId'] as int,
      json['destUserId'] as int,
      json['destUserName'] as String,
      json['sourceUserId'] as int,
      json['sourceUserName'] as String,
      json['content'] as String,
      json['action'] as int,
      json['createtime'] as String)
    ..showReply = json['showReply'] as bool;
}

Map<String, dynamic> _$CommentVOToJson(CommentVO instance) => <String, dynamic>{
      'id': instance.id,
      'blogId': instance.blogId,
      'destUserId': instance.destUserId,
      'destUserName': instance.destUserName,
      'sourceUserId': instance.sourceUserId,
      'sourceUserName': instance.sourceUserName,
      'content': instance.content,
      'action': instance.action,
      'createtime': instance.createtime,
      'showReply': instance.showReply
    };

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment()
    ..id = json['id'] as int
    ..blogId = json['blogId'] as int
    ..destUserId = json['destUserId'] as int
    ..sourceUserId = json['sourceUserId'] as int
    ..content = json['content'] as String
    ..action = json['action'] as int
    ..createtime = json['createtime'] as String;
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'blogId': instance.blogId,
      'destUserId': instance.destUserId,
      'sourceUserId': instance.sourceUserId,
      'content': instance.content,
      'action': instance.action,
      'createtime': instance.createtime
    };
