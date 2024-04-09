part of 'purchase_orders_bloc.dart';

abstract class PurchaseOrdersEvent extends Equatable {
  const PurchaseOrdersEvent();

  @override
  List<Object> get props => [];
}

class GetPurchaseOrdersEvent extends PurchaseOrdersEvent {
  final int jobId;

  const GetPurchaseOrdersEvent({required this.jobId});

  @override
  List<Object> get props => [jobId];
}
