// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'purchase_orders_bloc.dart';

abstract class PurchaseOrdersState extends Equatable {
  const PurchaseOrdersState();

  @override
  List<Object> get props => [];
}

class PurchaseOrdersInitial extends PurchaseOrdersState {}

class PurchaseOrdersLoading extends PurchaseOrdersState {}

class PurchaseOrdersLoaded extends PurchaseOrdersState {
  final List<Item> items;
  final List<Category> categories;
  final List<PurchaseOrder> orders;

  const PurchaseOrdersLoaded({
    required this.items,
    required this.categories,
    required this.orders,
  });

  @override
  List<Object> get props => [items, categories, orders];
}

class PurchaseOrdersFailed extends PurchaseOrdersState {
  final Failure failure;

  const PurchaseOrdersFailed({required this.failure});

  @override
  List<Object> get props => [failure];
}
