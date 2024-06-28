// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<Item> items;
  final List<Category> categories;
  final List<PurchaseOrder> orders;
  final List<Contact> suppliers;
  final List<Item> selectedItems;
  final List<Item> updatedItems;
  final bool itemModified;

  const ItemsLoaded({
    required this.items,
    required this.categories,
    required this.orders,
    required this.suppliers,
    this.selectedItems = const [],
    this.updatedItems = const [],
    this.itemModified = false,
  });

  @override
  List<Object> get props => [
        items,
        categories,
        orders,
        suppliers,
        selectedItems,
        updatedItems,
        itemModified,
      ];

  ItemsLoaded copyWith({
    List<Item>? items,
    List<Category>? categories,
    List<PurchaseOrder>? orders,
    List<Contact>? suppliers,
    List<Item>? selectedItems,
    List<Item>? updatedItems,
    bool? itemModified,
  }) {
    return ItemsLoaded(
      items: items ?? this.items,
      categories: categories ?? this.categories,
      orders: orders ?? this.orders,
      suppliers: suppliers ?? this.suppliers,
      selectedItems: selectedItems ?? this.selectedItems,
      updatedItems: updatedItems ?? this.updatedItems,
      itemModified: itemModified ?? this.itemModified,
    );
  }
}

class ItemsFailed extends ItemsState {
  final Failure failure;

  const ItemsFailed({required this.failure});

  @override
  List<Object> get props => [failure];
}
