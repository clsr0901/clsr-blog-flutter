import 'package:json_annotation/json_annotation.dart';

part 'SourceResponse.g.dart';


@JsonSerializable()
class SourcesResponse extends Object {
  String msg;
  List<Source> data;

  SourcesResponse(this.msg, this.data);

  //不同的类使用不同的mixin即可
  factory SourcesResponse.fromJson(Map<String, dynamic> json) =>
      _$SourcesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SourcesResponseToJson(this);
}

@JsonSerializable()
class SourceResponse extends Object {
  String msg;
  Source data;

  SourceResponse(this.msg, this.data);

  //不同的类使用不同的mixin即可
  factory SourceResponse.fromJson(Map<String, dynamic> json) =>
      _$SourceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SourceResponseToJson(this);
}

@JsonSerializable()
class Source extends Object {
  int id;
  int userId;
  String name;
  String uid;
  String url;
  num length;
  String mime;
  int type;
  String createtime;
  bool download = false;
  double percent = 0.0;


  Source(this.userId, this.name, this.uid, this.url, this.length,
      this.mime, this.type);//不同的类使用不同的mixin即可

  factory Source.fromJson(Map<String, dynamic> json) =>
      _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}