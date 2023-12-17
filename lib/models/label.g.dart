// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelModel _$LabelModelFromJson(Map<String, dynamic> json) => LabelModel(
      name: json['name'] as String,
      color: _$JsonConverterFromJson<int, Color>(
          json['color'], const ColorSerializer().fromJson),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$LabelModelToJson(LabelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': _$JsonConverterToJson<int, Color>(
          instance.color, const ColorSerializer().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
