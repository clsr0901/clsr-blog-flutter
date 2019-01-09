// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Err.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Err _$ErrFromJson(Map<String, dynamic> json) {
  return Err(
      json['timestamp'] as int,
      json['status'] as int,
      json['error'] as String,
      json['message'] as String,
      json['path'] as String);
}

Map<String, dynamic> _$ErrToJson(Err instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'path': instance.path
    };
