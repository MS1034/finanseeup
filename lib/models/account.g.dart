// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      accountName: json['accountName'] as String?,
      type: json['type'] as String?,
      currency: json['currency'] as String?,
      color: _$JsonConverterFromJson<int, Color>(
          json['color'], const ColorSerializer().fromJson),
      id: json['id'] as String?,
      amount: json['amount'] is String
          ? double.tryParse(json['amount'] ?? '') ?? 0
          : (json['amount'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$AccountToJson(Account instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['accountName'] = instance.accountName;
  val['type'] = instance.type;
  val['currency'] = instance.currency;
  val['amount'] = instance.amount;
  val['color'] = _$JsonConverterToJson<int, Color>(
      instance.color, const ColorSerializer().toJson);
  return val;
}

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
