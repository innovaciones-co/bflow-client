import 'dart:convert';

import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.contact,
    required super.parentCategory,
  });

  factory CategoryModel.fromJson(String str) =>
      CategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        contact: json["contact"],
        parentCategory: json["parentCategory"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "contact": contact,
        "parentCategory": parentCategory,
      };

  factory CategoryModel.fromEntity(Category category) => CategoryModel(
        id: category.id,
        name: category.name,
        contact: category.contact,
        parentCategory: category.parentCategory,
      );
}
