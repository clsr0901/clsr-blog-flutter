// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BlogResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogResponse _$BlogResponseFromJson(Map<String, dynamic> json) {
  return BlogResponse(
      json['msg'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : BlogVO.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$BlogResponseToJson(BlogResponse instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': instance.data};

BlogVOResponse _$BlogVOResponseFromJson(Map<String, dynamic> json) {
  return BlogVOResponse(
      json['msg'] as String,
      json['data'] == null
          ? null
          : BlogVO.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$BlogVOResponseToJson(BlogVOResponse instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': instance.data};

BlogVO _$BlogVOFromJson(Map<String, dynamic> json) {
  return BlogVO(
      json['id'] as int,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['title'] as String,
      json['content'] as String,
      json['summary'] as String,
      json['hit'] as int,
      json['view'] as int,
      json['comments'] as int,
      json['sticky'] as bool,
      json['highlight'] as bool,
      json['createtime'] as String,
      json['updatetime'] as String);
}

Map<String, dynamic> _$BlogVOToJson(BlogVO instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'title': instance.title,
      'content': instance.content,
      'summary': instance.summary,
      'hit': instance.hit,
      'view': instance.view,
      'comments': instance.comments,
      'sticky': instance.sticky,
      'highlight': instance.highlight,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime
    };
