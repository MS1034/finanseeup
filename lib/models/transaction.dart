import 'package:finanseeup/models/crud_model.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class TransactionModel extends CrudModel {
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
      this.id})
      : accountIdTo = '',
        receiptImage = '';

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  factory TransactionModel.fromJsonLocally(Map<String, dynamic> json) =>
      _$TransactionModelFromJsonLocally(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  @override
  Map<String, dynamic> toJsonLocally() => _$TransactionModelToJsonLocally(this);

  // @override
  // TransactionModel fromJson(Map<String, dynamic> json) {
  //   return _$TransactionModelFromJson(json);
  // }
}
