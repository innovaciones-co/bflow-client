import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int? id;
  final String name;
  final String? description;
  final double unitPrice;
  final int vat;
  final double price;
  final int units;
  final String? measure;
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

  @override
  List<Object?> get props => throw UnimplementedError();
}
