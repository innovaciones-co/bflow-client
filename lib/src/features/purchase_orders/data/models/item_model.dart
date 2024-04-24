import 'dart:convert';

import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/units.dart';

class ItemModel extends Item {
  const ItemModel({
    required super.id,
    required super.name,
    super.description,
    super.unitPrice,
    super.vat,
    super.price,
    super.units,
    super.measure,
    super.purchaseOrder,
    required super.supplier,
    required super.job,
    required super.category,
  });

  factory ItemModel.fromJson(String str) => ItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        unitPrice: json["unitPrice"]?.toDouble(),
        vat: json["vat"]?.toDouble(),
        price: json["price"]?.toDouble(),
        units: json["units"],
        measure:
            json["measure"] != null ? Unit.fromString(json["measure"]) : null,
        purchaseOrder: json["purchaseOrder"],
        supplier: json["supplier"],
        category: json["category"],
        job: json["job"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "unitPrice": unitPrice,
        "vat": vat,
        "price": price,
        "units": units,
        "measure": measure?.toJSON(),
        "purchaseOrder": purchaseOrder,
        "supplier": supplier,
        "category": category,
        "job": job,
      };

  factory ItemModel.fromEntity(Item item) => ItemModel(
        id: item.id,
        name: item.name,
        description: item.description,
        unitPrice: item.unitPrice,
        vat: item.vat,
        price: item.price,
        units: item.units,
        measure: item.measure,
        purchaseOrder: item.purchaseOrder,
        supplier: item.supplier,
        job: item.job,
        category: item.category,
      );
}
