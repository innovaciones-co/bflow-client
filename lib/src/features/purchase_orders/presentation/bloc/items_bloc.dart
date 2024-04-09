import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_categories_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_items_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_purchase_orders_by_job_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final GetItemsUseCase getItemsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetContactsUseCase getSuppliersUseCase;
  final GetPurchaseOrdersByJobUseCase getOrdersUseCase;

  ItemsBloc({
    required this.getCategoriesUseCase,
    required this.getSuppliersUseCase,
    required this.getItemsUseCase,
    required this.getOrdersUseCase,
  }) : super(ItemsLoading()) {
    on<GetItemsEvent>((event, emit) async {
      emit(ItemsLoading());
      final params = GetItemsParams(jobId: event.jobId);
      var items = await getItemsUseCase.execute(params);
      var suppliers = await getSuppliersUseCase
          .execute(GetContactsParams(contactType: ContactType.supplier));
      var categories = await getCategoriesUseCase.execute(NoParams());
      var orders = await getOrdersUseCase
          .execute(GetPurchaseOrdersByJobParams(jobId: event.jobId));

      items.fold(
        (l) => emit(
          ItemsFailed(failure: l),
        ),
        (mat) async {
          suppliers.fold(
            (l) => emit(ItemsFailed(failure: l)),
            (sup) {
              categories.fold(
                (l) => emit(ItemsFailed(failure: l)),
                (cat) {
                  orders.fold(
                    (l) => emit(ItemsFailed(failure: l)),
                    (ord) {
                      emit(
                        ItemsLoaded(
                          items: mat,
                          categories: cat,
                          orders: ord,
                          suppliers: sup,
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      );
    });
  }
}
