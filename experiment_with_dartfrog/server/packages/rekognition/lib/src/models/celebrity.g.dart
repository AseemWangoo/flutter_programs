// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'celebrity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CelebrityModelResponse _$CelebrityModelResponseFromJson(
        Map<String, dynamic> json) =>
    CelebrityModelResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CelebrityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CelebrityModelResponseToJson(
        CelebrityModelResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CelebrityModel _$CelebrityModelFromJson(Map<String, dynamic> json) =>
    CelebrityModel(
      name: json['name'] as String?,
      urls: (json['urls'] as List<dynamic>?)?.map((e) => e as String).toList(),
      matchConfidence: (json['matchConfidence'] as num?)?.toDouble(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$CelebrityModelToJson(CelebrityModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'urls': instance.urls,
      'matchConfidence': instance.matchConfidence,
      'id': instance.id,
    };
