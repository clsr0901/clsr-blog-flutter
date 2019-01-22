// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SourceResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourcesResponse _$SourcesResponseFromJson(Map<String, dynamic> json) {
  return SourcesResponse(
      json['msg'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Source.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SourcesResponseToJson(SourcesResponse instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': instance.data};

SourceResponse _$SourceResponseFromJson(Map<String, dynamic> json) {
  return SourceResponse(
      json['msg'] as String,
      json['data'] == null
          ? null
          : Source.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$SourceResponseToJson(SourceResponse instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': instance.data};

Source _$SourceFromJson(Map<String, dynamic> json) {
  return Source(
      json['userId'] as int,
      json['name'] as String,
      json['uid'] as String,
      json['url'] as String,
      json['length'] as num,
      json['mime'] as String,
      json['type'] as int)
    ..id = json['id'] as int
    ..createtime = json['createtime'] as String
    ..download = json['download'] as bool
    ..percent = (json['percent'] as num)?.toDouble();
}

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'uid': instance.uid,
      'url': instance.url,
      'length': instance.length,
      'mime': instance.mime,
      'type': instance.type,
      'createtime': instance.createtime,
      'download': instance.download,
      'percent': instance.percent
    };
