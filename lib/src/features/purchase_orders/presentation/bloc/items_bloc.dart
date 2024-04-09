import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_items_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final GetItemsUseCase getItemsUseCase;

  ItemsBloc({required this.getItemsUseCase}) : super(ItemsLoading()) {
    on<ItemsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetItemsEvent>((event, emit) async {
      emit(ItemsLoading());
      final params = GetItemsParams(jobId: event.jobId);
      var items = await getItemsUseCase.execute(params);
      items.fold(
        (l) => emit(
          ItemsFailed(failure: l),
        ),
        (r) {
          emit(ItemsLoaded(
            items: r,
            categories: const [],
            orders: const [],
            suppliers: const [],
          ));
        },
      );
    });
  }
}
