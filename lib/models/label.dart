import 'dart:ui';
import 'package:json_annotation/json_annotation.dart';

import 'json_color_convertor.dart';

part 'label.g.dart';

@JsonSerializable()
class LabelModel {
  late String? id;
  final String name;

  @override
  @ColorSerializer()
  late Color? color;

  LabelModel({
    required this.name,
    this.color,
    this.id
  });

  factory LabelModel.fromJson(Map<String, dynamic> json) =>
      _$LabelModelFromJson(json);

  Map<String, dynamic> toJson() => _$LabelModelToJson(this);

  static Color? _colorFromJson(int? json) {
    return json != null ? Color(json) : null;
  }

  static int? _colorToJson(Color? color) {
    return color?.value;
  }
}
