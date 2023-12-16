import 'package:json_annotation/json_annotation.dart';
import 'account.dart';
import 'enum_period.dart';
import 'label.dart';

part 'budget_model.g.dart';

@JsonSerializable()
class BudgetModel {

  @JsonKey(includeIfNull: false)

  late String? id;

  final String name;
  final Period period;
  final double amount;
  final String currency;
  final List<String> categories;
  @JsonKey(includeIfNull: false)
  final List<Account>? accounts;
  @JsonKey(includeIfNull: false)
  final List<LabelModel>? labels;

  BudgetModel({
    required this.name,
    required this.period,
    required this.amount,
    required this.currency,
    required this.categories,
    this.id,
    this.accounts,
    this.labels,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetModelToJson(this);
}
