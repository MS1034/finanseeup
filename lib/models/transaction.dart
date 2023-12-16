import 'account.dart';
import 'package:json_annotation/json_annotation.dart';
import 'enum_payment_type.dart';
import 'enum_transaction_type.dart';
import 'label.dart';

part 'transaction.g.dart';

@JsonSerializable()
class TransactionModel {
  late String? id;

  final Account account;
  final String category;
  final double amount;
  @JsonKey(includeIfNull: false)
  final String? description;
  @JsonKey(includeIfNull: false)
  final List<LabelModel>? labels;
  @JsonKey(includeIfNull: false)
  final String? payee;
  @JsonKey(includeIfNull: false)
  final DateTime? dateTime;
  final PaymentType paymentType;
  @JsonKey(includeIfNull: false)
  final String? receiptImage;
  @JsonKey(includeIfNull: false)
  final TransactionType? transactionType;

  TransactionModel({
    required this.account,
    required this.category,
    required this.amount,
    required this.paymentType,
    this.description,
    this.labels,
    this.payee,
    this.dateTime,
    this.receiptImage,
    this.transactionType,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
