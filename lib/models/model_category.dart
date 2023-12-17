import 'package:json_annotation/json_annotation.dart';

part 'model_category.g.dart';

@JsonSerializable()
class CategoryModel {

  @JsonKey(includeIfNull: false)

  late String? id;
  late String? name;

  @JsonKey(includeIfNull: false)

  late String? icon;
  @JsonKey(includeIfNull: false)

  late List<CategoryModel>? subcategories;

  CategoryModel({
    required this.name,
    this.subcategories,
    this.id,
    this.icon

  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class SubcategoryModel {

  @JsonKey(includeIfNull: false)

  final String? id;

  @JsonKey(includeIfNull: false)

  final String name;

  SubcategoryModel({
     required this.name,
    this.id,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryModelToJson(this);
}
