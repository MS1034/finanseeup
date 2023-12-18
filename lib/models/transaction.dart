import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class TransactionModel {
  @JsonKey(includeIfNull: false)
  final String? id;

  final String accountId;

  @JsonKey(includeIfNull: false)
  final String? category;
  final double amount;

  @JsonKey(includeIfNull: false)
  late String? accountIdTo;

  final String? description;
  @JsonKey(includeIfNull: false)
  final List<String>? labels;
  @JsonKey(includeIfNull: false)
  final String? payee;
  @JsonKey(includeIfNull: false)
  final DateTime? dateTime;

  @JsonKey(includeIfNull: false)
  final String? paymentType;
  @JsonKey(includeIfNull: false)
  late String? receiptImage;
  @JsonKey(includeIfNull: false)
  final String? transactionType;

  TransactionModel(
      {required this.accountId,
      this.category,
      required this.amount,
      required this.paymentType,
      this.description,
      this.labels,
      this.payee,
      this.dateTime,
      this.transactionType,
      this.id});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
