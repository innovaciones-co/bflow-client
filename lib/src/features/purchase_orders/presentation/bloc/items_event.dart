part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class LoadingItemsEvent extends ItemsEvent {}

class GetItemsEvent extends ItemsEvent {
  final int jobId;

  const GetItemsEvent({required this.jobId});

  @override
  List<Object> get props => [jobId];
}

class ToggleSelectedItemEvent extends ItemsEvent {
  final Item item;

  const ToggleSelectedItemEvent({required this.item});
}

class CreatePurchaseOrderEvent extends ItemsEvent {
  final int jobId;

  const CreatePurchaseOrderEvent({required this.jobId});
}
