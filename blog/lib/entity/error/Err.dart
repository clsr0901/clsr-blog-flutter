import 'package:json_annotation/json_annotation.dart';

part 'Err.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Err extends Object {
  int timestamp;
  int status;
  String error;
  String message;
  String path;

  Err(this.timestamp, this.status, this.error, this.message,
      this.path); //不同的类使用不同的mixin即可
  factory Err.fromJson(Map<String, dynamic> json) => _$ErrFromJson(json);

  Map<String, dynamic> toJson() => _$ErrToJson(this);
}
