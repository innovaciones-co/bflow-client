import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/get_categories_use_case.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/create_purchase_order_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/delete_item_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_items_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_purchase_orders_by_job_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final GetItemsUseCase getItemsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetContactsUseCase getSuppliersUseCase;
  final GetPurchaseOrdersByJobUseCase getOrdersUseCase;
  final CreatePurchaseOrderUseCase createPurchaseOrderUseCase;
  final DeleteItemUseCase deleteItemUseCase;
  final HomeBloc? homeBloc;

  ItemsBloc({
    required this.getCategoriesUseCase,
    required this.getSuppliersUseCase,
    required this.getItemsUseCase,
    required this.getOrdersUseCase,
    required this.createPurchaseOrderUseCase,
    required this.deleteItemUseCase,
    required this.homeBloc,
  }) : super(ItemsLoading()) {
    on<DeleteItemsEvent>(
      (event, emit) async {
        if (state is ItemsLoaded) {
          var loadedState = (state as ItemsLoaded);
          var selectedItems = List<Item>.from(loadedState.selectedItems);

          for (var e in selectedItems) {
            var item =
                await deleteItemUseCase.execute(DeleteItemParams(id: e.id!));
            item.fold(
              (failure) => homeBloc?.add(
                ShowMessageEvent(
                    message:
                        "Item ${e.id} couldn't be deleted: ${failure.message}",
                    type: AlertType.error),
              ),
              (r) {
                add(GetItemsEvent(jobId: e.job));
              },
            );
          }
        }
      },
    );
    on<LoadingItemsEvent>(
      (event, emit) => emit(ItemsLoading()),
    );
    on<ToggleSelectedItemEvent>(
      (event, emit) {
        if (state is ItemsLoaded) {
          var loadedState = (state as ItemsLoaded);
          var selectedItems = List<Item>.from(loadedState.selectedItems);
          var item = event.item;

          if (selectedItems.contains(item)) {
            selectedItems.remove(item);
          } else {
            selectedItems.add(item);
          }

          emit(
            loadedState.copyWith(selectedItems: selectedItems),
          );
        }
      },
    );
    on<SelectItemsByCategory>(
      (event, emit) {
        if (state is! ItemsLoaded) return;

        var categoryId = event.categoryId;
        List<Item> items = (state as ItemsLoaded).items;
        List<Item> selectedItems =
            (state as ItemsLoaded).selectedItems.toList();

        bool selected =
            !_checkIfCategorySelected(categoryId, selectedItems, items);

        var itemsOfCategory =
            items.where((item) => item.category == categoryId);

        for (var item in itemsOfCategory) {
          if (selectedItems.contains(item)) {
            if (!selected) {
              selectedItems.remove(item);
            }
          } else {
            if (selected) {
              selectedItems.add(item);
            }
          }
        }

        emit(
          (state as ItemsLoaded).copyWith(
            selectedItems: selectedItems,
          ),
        );
      },
    );
    on<CreatePurchaseOrderEvent>(_createPurchaseOrder);
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

  _createPurchaseOrder(
      CreatePurchaseOrderEvent event, Emitter<ItemsState> emit) async {
    if (state is! ItemsLoaded) {
      return;
    }

    var selectedItems = (state as ItemsLoaded).selectedItems;
    var failureOrOrders = await createPurchaseOrderUseCase.execute(
      CreatePurchaseOrderParams(
        jobId: event.jobId,
        items: selectedItems
            .where((element) => element.purchaseOrder == null)
            .toList(),
      ),
    );

    failureOrOrders.fold(
      (l) => debugPrint(l.message),
      (r) => add(GetItemsEvent(jobId: event.jobId)),
    );
  }

  bool _checkIfCategorySelected(
      int categoryId, List<Item> selectedItems, List<Item> allItems) {
    var itemsOfCategory = allItems.where((item) => item.category == categoryId);

    if (itemsOfCategory
        .every((categoryItem) => selectedItems.contains(categoryItem))) {
      return true;
    }
    return false;
  }
}
