import 'dart:convert';
import 'dart:ui';
import 'package:json_annotation/json_annotation.dart';

import 'json_color_convertor.dart';

part 'goal.g.dart';

@JsonSerializable()
class Goal {

  @JsonKey(includeIfNull: false)

  late String? id;
  final String name;
  final double amount;
  final double moneySaved;
  final DateTime desiredDate;
  @override
  @ColorSerializer()
  late Color color;

  @JsonKey(includeIfNull: false)
  late String? note;

  Goal({
    required this.name,
    required this.amount,
    required this.moneySaved,
    required this.desiredDate,
    this.note,
    this.id,

  });

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  Map<String, dynamic> toJson() => _$GoalToJson(this);





}
String _colorToJson(Color color) => jsonEncode(color.value);
Color _colorFromJson(String json) => Color(int.parse(json));
