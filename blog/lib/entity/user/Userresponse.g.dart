// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Userresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Userresponse _$UserresponseFromJson(Map<String, dynamic> json) {
  return Userresponse(
      json['msg'] as String,
      json['data'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
      json['token'] as String);
}

Map<String, dynamic> _$UserresponseToJson(Userresponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'data': instance.data,
      'token': instance.token
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['id'] as int,
      json['username'] as String,
      json['avatar'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['instruction'] as String,
      json['createtime'] as String,
      json['blogs'] as int,
      json['comments'] as int);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'email': instance.email,
      'phone': instance.phone,
      'instruction': instance.instruction,
      'createtime': instance.createtime,
      'blogs': instance.blogs,
      'comments': instance.comments
    };
