import 'package:bflow_client/src/features/catalog/domain/entities/units.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;
  final String name;
  final String sku;
  final String? description;
  final double unitPrice;
  final double? vat;
  final Unit unitOfMeasure;
  final double? uomOrderIncrement;
  final String? url;
  final int category;
  final int supplier;
  final DateTime? dateUpdated;

  const Product({
    this.id,
    required this.name,
    required this.sku,
    this.description,
    required this.unitPrice,
    this.vat,
    required this.unitOfMeasure,
    this.uomOrderIncrement,
    this.url,
    required this.category,
    required this.supplier,
    this.dateUpdated,
  });

  @override
  List<Object> get props => [
        id ?? '',
        name,
        sku,
        description ?? '',
        unitPrice,
        vat ?? '',
        unitOfMeasure,
        uomOrderIncrement ?? '',
        url ?? '',
        category,
        supplier,
        dateUpdated ?? '',
      ];

  @override
  bool? get stringify => true;
}
