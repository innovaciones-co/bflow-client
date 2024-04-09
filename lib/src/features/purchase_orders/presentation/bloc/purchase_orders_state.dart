part of 'purchase_orders_bloc.dart';

abstract class PurchaseOrdersState extends Equatable {
  const PurchaseOrdersState();  

  @override
  List<Object> get props => [];
}
class PurchaseOrdersInitial extends PurchaseOrdersState {}
