import 'package:bflow_client/src/features/purchase_orders/data/models/item_model.dart';

class PurchaseOrderItemsModel {
  final int job;
  final List<ItemModel> items;

  PurchaseOrderItemsModel({required this.job, required this.items});

  Map<String, dynamic> toMap() => {
        "job": job,
        "items": List<dynamic>.from(items.map((e) => e.toMap())),
      };
}
