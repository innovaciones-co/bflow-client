import 'package:bflow_client/src/features/purchase_orders/domain/entities/units.dart';

class Product {
  final int? id;
  final String name;
  final String sku;
  final String? description;
  final double unitPrice;
  final Unit unitOfMeasure;
  final int? uomOrderIncrement;
  final String? url;
  final int category;

  Product({
    this.id,
    required this.name,
    required this.sku,
    this.description,
    required this.unitPrice,
    required this.unitOfMeasure,
    required this.uomOrderIncrement,
    required this.url,
    required this.category,
  });
}
