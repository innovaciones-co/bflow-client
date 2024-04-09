import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_items_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'purchase_orders_event.dart';
part 'purchase_orders_state.dart';

class PurchaseOrdersBloc
    extends Bloc<PurchaseOrdersEvent, PurchaseOrdersState> {
  final GetItemsUseCase getItemsUseCase;

  PurchaseOrdersBloc({required this.getItemsUseCase})
      : super(PurchaseOrdersInitial()) {
    on<PurchaseOrdersEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetPurchaseOrdersEvent>((event, emit) async {
      emit(PurchaseOrdersLoading());
      final params = GetItemsParams(jobId: event.jobId);
      var items = await getItemsUseCase.execute(params);
      items.fold(
        (l) => emit(
          PurchaseOrdersFailed(failure: l),
        ),
        (r) {
          emit(PurchaseOrdersLoaded(
            items: r,
            categories: const [],
            orders: const [],
          ));
        },
      );
    });
  }
}
