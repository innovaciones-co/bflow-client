import 'package:bflow_client/src/features/catalog/domain/entities/units.dart';
import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int? id;
  final String name;
  final String? description;
  final double unitPrice;
  final double vat;
  final double price;
  final int units;
  final Unit? measure;
  final int? purchaseOrder;
  final int supplier;
  final int category;
  final int job;

  const Item({
    this.id,
    required this.name,
    this.description,
    this.unitPrice = 0,
    this.vat = 0,
    this.price = 0.0,
    this.units = 0,
    this.measure,
    this.purchaseOrder,
    required this.supplier,
    required this.category,
    required this.job,
  });

  Item copyWith({
    int? id,
    String? name,
    String? description,
    double? unitPrice,
    double? vat,
    double? price,
    int? units,
    Unit? measure,
    int? purchaseOrder,
    int? supplier,
    int? category,
    int? job,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      unitPrice: unitPrice ?? this.unitPrice,
      vat: vat ?? this.vat,
      price: price ?? this.price,
      units: units ?? this.units,
      measure: measure ?? this.measure,
      purchaseOrder: purchaseOrder ?? this.purchaseOrder,
      supplier: supplier ?? this.supplier,
      category: category ?? this.category,
      job: job ?? this.job,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        unitPrice,
        vat,
        price,
        units,
        measure,
        purchaseOrder,
        supplier,
        category,
        job,
      ];
}
