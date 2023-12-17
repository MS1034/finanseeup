import 'package:json_annotation/json_annotation.dart';
import 'account.dart';
import 'enum_period.dart';
import 'label.dart';

part 'budget.g.dart';

@JsonSerializable()
class Budget {

  @JsonKey(includeIfNull: false)

  final String? id;

  final String name;
  final Period period;
  final double amount;
  final String currency;
  final List<String> categories;
  @JsonKey(includeIfNull: false)
  final List<Account>? accounts;
  @JsonKey(includeIfNull: false)
  final List<LabelModel>? labels;

  Budget({
    required this.name,
    required this.period,
    required this.amount,
    required this.currency,
    required this.categories,
    this.accounts,
    this.labels,
    this.id
  });

  factory Budget.fromJson(Map<String, dynamic> json) =>
      _$BudgetFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetToJson(this);
}
