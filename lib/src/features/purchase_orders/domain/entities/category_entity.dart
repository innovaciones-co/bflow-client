import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final int contact;
  final int? parentCategory;

  const Category({
    required this.id,
    required this.name,
    required this.contact,
    this.parentCategory,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        contact,
        parentCategory,
      ];

  @override
  bool? get stringify => true;
}
