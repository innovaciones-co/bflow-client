part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class GetItemsEvent extends ItemsEvent {
  final int jobId;

  const GetItemsEvent({required this.jobId});

  @override
  List<Object> get props => [jobId];
}
