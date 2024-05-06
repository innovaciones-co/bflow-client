import 'package:bflow_client/src/features/catalog/domain/entities/units.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;
  final String name;
  final String sku;
  final String? description;
  final double unitPrice;
  final int? vat;
  final Unit unitOfMeasure;
  final int? uomOrderIncrement;
  final String? url;
  final int category;

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
      ];

  @override
  bool? get stringify => true;
}
