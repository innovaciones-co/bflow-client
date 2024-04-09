import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'purchase_orders_event.dart';
part 'purchase_orders_state.dart';

class PurchaseOrdersBloc extends Bloc<PurchaseOrdersEvent, PurchaseOrdersState> {
  PurchaseOrdersBloc() : super(PurchaseOrdersInitial()) {
    on<PurchaseOrdersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
