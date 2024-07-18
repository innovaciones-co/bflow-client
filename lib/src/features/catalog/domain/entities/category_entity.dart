import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int? id;
  final String name;
  final int tradeCode;
  final int? parentCategory;

  const Category({
    this.id,
    required this.name,
    required this.tradeCode,
    this.parentCategory,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        tradeCode,
        parentCategory,
      ];

  @override
  bool? get stringify => true;
}
