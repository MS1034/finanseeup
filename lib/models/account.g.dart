// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      accountName: json['accountName'] as String,
      type: $enumDecode(_$AccountTypeEnumMap, json['type']),
      currency: json['currency'] as String,
    )
      ..id = json['id'] as String?
      ..amount = (json['amount'] as num?)?.toDouble() ?? 0
      ..color = const ColorSerializer().fromJson(json['color'] as int);

Map<String, dynamic> _$AccountToJson(Account instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['accountName'] = instance.accountName;
  val['type'] = _$AccountTypeEnumMap[instance.type]!;
  val['currency'] = instance.currency;
  val['amount'] = instance.amount;
  val['color'] = const ColorSerializer().toJson(instance.color);
  return val;
}

const _$AccountTypeEnumMap = {
  AccountType.Cash: 'Cash',
  AccountType.Credit: 'Credit',
};
