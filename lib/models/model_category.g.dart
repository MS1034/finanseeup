// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      name: json['name'] as String?,
      subcategories: (json['subcategories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  writeNotNull('icon', instance.icon);
  writeNotNull('subcategories', instance.subcategories);
  return val;
}

SubcategoryModel _$SubcategoryModelFromJson(Map<String, dynamic> json) =>
    SubcategoryModel(
      name: json['name'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$SubcategoryModelToJson(SubcategoryModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  return val;
}
