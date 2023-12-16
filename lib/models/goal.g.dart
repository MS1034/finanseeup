// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) => Goal(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      moneySaved: (json['moneySaved'] as num).toDouble(),
      desiredDate: DateTime.parse(json['desiredDate'] as String),
      color: const ColorSerializer().fromJson(json['color'] as int),
      note: json['note'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$GoalToJson(Goal instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['amount'] = instance.amount;
  val['moneySaved'] = instance.moneySaved;
  val['desiredDate'] = instance.desiredDate.toIso8601String();
  val['color'] = const ColorSerializer().toJson(instance.color);
  writeNotNull('note', instance.note);
  return val;
}
