import 'dart:ui';
import 'package:json_annotation/json_annotation.dart';
import 'enum_account_type.dart';
import 'json_color_convertor.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  @JsonKey(includeIfNull: false)
  late String? id;

  final String accountName;
  final AccountType type;
  final String currency;

  @JsonKey(defaultValue: 0)
  late double amount;
  @override
  @ColorSerializer()
  late Color color;

  Account({
    required this.accountName,
    required this.type,
    required this.currency,
  });

  // Factory method to create an Account object from a JSON map
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  // Method to convert an Account object to a JSON map
  Map<String, dynamic> toJson() => _$AccountToJson(this);

  static Color? _colorFromJson(int? json) {
    return json != null ? Color(json) : null;
  }

  static int? _colorToJson(Color? color) {
    return color?.value;
  }
}