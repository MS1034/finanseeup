// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      account: Account.fromJson(json['account'] as Map<String, dynamic>),
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      paymentType: $enumDecode(_$PaymentTypeEnumMap, json['paymentType']),
      description: json['description'] as String?,
      labels: (json['labels'] as List<dynamic>?)
          ?.map((e) => LabelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      payee: json['payee'] as String?,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      receiptImage: json['receiptImage'] as String?,
      transactionType: $enumDecodeNullable(
          _$TransactionTypeEnumMap, json['transactionType']),
    )..id = json['id'] as String?;

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'account': instance.account,
    'category': instance.category,
    'amount': instance.amount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('labels', instance.labels);
  writeNotNull('payee', instance.payee);
  writeNotNull('dateTime', instance.dateTime?.toIso8601String());
  val['paymentType'] = _$PaymentTypeEnumMap[instance.paymentType]!;
  writeNotNull('receiptImage', instance.receiptImage);
  writeNotNull(
      'transactionType', _$TransactionTypeEnumMap[instance.transactionType]);
  return val;
}

const _$PaymentTypeEnumMap = {
  PaymentType.Cash: 'Cash',
  PaymentType.CreditCard: 'CreditCard',
  PaymentType.DebitCard: 'DebitCard',
  PaymentType.OnlinePayment: 'OnlinePayment',
};

const _$TransactionTypeEnumMap = {
  TransactionType.Income: 'Income',
  TransactionType.Expense: 'Expense',
  TransactionType.Transfer: 'Transfer',
};
