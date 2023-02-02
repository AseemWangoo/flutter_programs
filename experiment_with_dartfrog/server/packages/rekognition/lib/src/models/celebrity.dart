import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'celebrity.g.dart';

@JsonSerializable()
class CelebrityModelResponse {
  CelebrityModelResponse({this.data});

  @JsonKey(name: 'data')
  List<CelebrityModel>? data;

  factory CelebrityModelResponse.fromJson(Map<String, dynamic> json) =>
      _$CelebrityModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CelebrityModelResponseToJson(this);
}

@immutable
@JsonSerializable()
class CelebrityModel extends Equatable {
  CelebrityModel({
    this.name,
    this.urls,
    this.matchConfidence,
    required this.id,
  });

  final String? name;
  final List<String>? urls;
  final double? matchConfidence;
  final String? id;

  CelebrityModel copyWith({
    String? name,
    List<String>? urls,
    double? matchConfidence,
    String? id,
  }) {
    return CelebrityModel(
      name: name ?? 'name',
      urls: urls ?? [],
      matchConfidence: matchConfidence ?? 0.0,
      id: id ?? 'id',
    );
  }

  static CelebrityModel fromJson(Map<String, dynamic> json) =>
      _$CelebrityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CelebrityModelToJson(this);

  @override
  List<Object?> get props => [name, urls, matchConfidence, id];
}
