import 'dart:convert';

import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';

class PurchaseOrderModel extends PurchaseOrder {
  const PurchaseOrderModel({
    required super.id,
    required super.number,
    required super.sentDate,
    required super.approvedDate,
    required super.completedDate,
    required super.status,
    required super.job,
  });

  factory PurchaseOrderModel.fromJson(String str) =>
      PurchaseOrderModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PurchaseOrderModel.fromMap(Map<String, dynamic> json) =>
      PurchaseOrderModel(
        id: json["id"],
        number: json["number"],
        sentDate: json["sentDate"],
        approvedDate: json["approvedDate"],
        completedDate: json["completedDate"],
        status: json["status"],
        job: json["job"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "number": number,
        "sentDate": sentDate,
        "approvedDate": approvedDate,
        "completedDate": completedDate,
        "status": status,
        "job": job,
      };

  factory PurchaseOrderModel.fromEntity(PurchaseOrder purchaseOrder) =>
      PurchaseOrderModel(
        id: purchaseOrder.id,
        number: purchaseOrder.number,
        sentDate: purchaseOrder.sentDate,
        approvedDate: purchaseOrder.approvedDate,
        completedDate: purchaseOrder.approvedDate,
        status: purchaseOrder.status,
        job: purchaseOrder.job,
      );
}
