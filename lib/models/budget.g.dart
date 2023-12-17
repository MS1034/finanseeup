// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Budget _$BudgetFromJson(Map<String, dynamic> json) => Budget(
      name: json['name'] as String,
      period: $enumDecode(_$PeriodEnumMap, json['period']),
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
          .toList(),
      labels: (json['labels'] as List<dynamic>?)
          ?.map((e) => LabelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$BudgetToJson(Budget instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['period'] = _$PeriodEnumMap[instance.period]!;
  val['amount'] = instance.amount;
  val['currency'] = instance.currency;
  val['categories'] = instance.categories;
  writeNotNull('accounts', instance.accounts);
  writeNotNull('labels', instance.labels);
  return val;
}

const _$PeriodEnumMap = {
  Period.Week: 'Week',
  Period.Month: 'Month',
  Period.Year: 'Year',
  Period.Quarter: 'Quarter',
};
