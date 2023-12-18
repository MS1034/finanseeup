import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

import 'json_color_convertor.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  @JsonKey(includeIfNull: false)
  String? id;

  final String? accountName;
  final String? type;
  final String? currency;

  @JsonKey(defaultValue: 0)
  double? amount;
  @override
  @ColorSerializer()
  Color? color;

  Account({
    required this.accountName,
    required this.type,
    required this.currency,
    this.color,
    this.id,
    this.amount,
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

  @override
  String toString() {
    return 'Account{id: $id, accountName: $accountName, type: $type, currency: $currency, amount: $amount, color: $color}';
  }

  // Override the == operator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Account &&
          runtimeType == other.runtimeType &&
          accountName == other.accountName &&
          type == other.type;

  // Override hashCode if you override ==
  @override
  int get hashCode => id.hashCode;

  Account copyWith({double? amount}) {
    return Account(
      id: id,
      accountName: accountName,
      type: type,
      currency: currency,
      amount: amount ?? this.amount,
      color: color,
    );
  }
}
