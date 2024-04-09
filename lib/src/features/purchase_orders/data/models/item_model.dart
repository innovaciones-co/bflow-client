import 'dart:convert';

import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';

class ItemModel extends Item {
  const ItemModel({
    required super.id,
    required super.name,
    required super.sku,
    required super.description,
    required super.unitPrice,
    required super.unitOfMeasure,
    required super.uomOrderIncrement,
    required super.url,
    required super.category,
  });

  factory ItemModel.fromJson(String str) => ItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        description: json["description"],
        unitPrice: json["unitPrice"]?.toDouble(),
        unitOfMeasure: json["unitOfMeasure"],
        uomOrderIncrement: json["uomOrderIncrement"],
        url: json["url"],
        category: json["category"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "sku": sku,
        "description": description,
        "unitPrice": unitPrice,
        "unitOfMeasure": unitOfMeasure,
        "uomOrderIncrement": uomOrderIncrement,
        "url": url,
        "category": category,
      };

  factory ItemModel.fromEntity(Item item) => ItemModel(
        id: item.id,
        name: item.name,
        sku: item.sku,
        description: item.description,
        unitPrice: item.unitPrice,
        unitOfMeasure: item.unitOfMeasure,
        uomOrderIncrement: item.uomOrderIncrement,
        url: item.url,
        category: item.category,
      );
}
