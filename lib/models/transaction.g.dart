// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      accountId: json['accountId'] as String,
      category: json['category'] as String?,
      amount: (json['amount'] as num).toDouble(),
      paymentType: json['paymentType'] as String?,
      description: json['description'] as String?,
      labels:
          (json['labels'] as List<dynamic>?)?.map((e) => e as String).toList(),
      payee: json['payee'] as String?,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      transactionType: json['transactionType'] as String?,
      id: json['id'] as String?,
    )
      ..accountIdTo = json['accountIdTo'] as String?
      ..receiptImage = json['receiptImage'] as String?;

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['accountId'] = instance.accountId;
  writeNotNull('category', instance.category);
  val['amount'] = instance.amount;
  writeNotNull('accountIdTo', instance.accountIdTo);
  val['description'] = instance.description;
  writeNotNull('labels', instance.labels);
  writeNotNull('payee', instance.payee);
  writeNotNull('dateTime', instance.dateTime?.toIso8601String());
  writeNotNull('paymentType', instance.paymentType);
  writeNotNull('receiptImage', instance.receiptImage);
  writeNotNull('transactionType', instance.transactionType);
  return val;
}
