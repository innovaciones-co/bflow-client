import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int id;
  final String name;
  final String sku;
  final String description;
  final double unitPrice;
  final String unitOfMeasure;
  final int uomOrderIncrement;
  final dynamic url;
  final int category;

  const Item({
    required this.sku,
    required this.description,
    required this.unitPrice,
    required this.unitOfMeasure,
    required this.uomOrderIncrement,
    this.url,
    required this.category,
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        sku,
        description,
        unitPrice,
        unitOfMeasure,
        uomOrderIncrement,
        url,
        category,
      ];

  @override
  bool? get stringify => true;
}
