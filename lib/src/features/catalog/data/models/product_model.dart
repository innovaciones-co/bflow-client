import 'dart:convert';

import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/units.dart';

class ProductModel extends Product {
  ProductModel({
    super.id,
    required super.name,
    super.description,
    required super.sku,
    required super.unitPrice,
    super.vat,
    required super.unitOfMeasure,
    super.uomOrderIncrement,
    super.url,
    required super.category,
    required super.supplier,
  });

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        description: json["description"],
        unitPrice: json["unitPrice"]?.toDouble(),
        vat: json["vat"],
        unitOfMeasure: Unit.fromString(json["unitOfMeasure"]),
        uomOrderIncrement: json["uomOrderIncrement"],
        url: json["url"],
        category: json["category"],
        supplier: json["supplier"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "sku": sku,
        "description": description,
        "unitPrice": unitPrice,
        "vat": vat,
        "unitOfMeasure": unitOfMeasure.toJSON(),
        "uomOrderIncrement": uomOrderIncrement,
        "url": url,
        "category": category,
        "supplier": supplier,
      };
}
