import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_suppliers_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/create_item_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_categories_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_items_use_case.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/get_products_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/presentation/bloc/items_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'write_item_state.dart';

class WriteItemCubit extends Cubit<WriteItemState> {
  final ItemsBloc itemsBloc;
  final int jobId;
  final CreateItemUseCase createItemUseCase;
  final GetSuppliersUseCase getSuppliersUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  final GetItemsUseCase getItemsUseCase;

  WriteItemCubit({
    required this.itemsBloc,
    required this.jobId,
    required this.createItemUseCase,
    required this.getSuppliersUseCase,
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
    required this.getItemsUseCase,
  }) : super(const WriteItemValidator());

  initForm() async {
    var failureOrContacts = await getSuppliersUseCase
        .execute(GetContactsParams(contactType: ContactType.supplier));
    failureOrContacts.fold(
      (l) => emit(state.copyWith(formStatus: FormStatus.failed)),
      (r) => emit(state.copyWith(suppliers: r, formStatus: FormStatus.loaded)),
    );
  }

  addItem() async {
    var product = state.product;

    if (product == null) {
      return;
    }

    var itemOrFailure = await createItemUseCase.execute(
      CreateItemParams(jobId: jobId, item: product, quantity: state.quantity),
    );

    itemOrFailure.fold(
      (l) => emit(
        state.copyWith(formStatus: FormStatus.failed, failure: l),
      ),
      (r) {
        emit(state.copyWith(formStatus: FormStatus.success));
        itemsBloc.add(GetItemsEvent(jobId: jobId));
      },
    );
  }

  void updateAutovalidateMode(AutovalidateMode autovalidateMode) {
    emit(state.copyWith(autovalidateMode: autovalidateMode));
  }

  void updateSuppliers(List<Contact> suppliers) {
    emit(state.copyWith(suppliers: suppliers));
  }

  void updateCategories(List<Category> categories) {
    emit(state.copyWith(categories: categories));
  }

  void updateItems(List<Product> items) {
    emit(state.copyWith(items: items));
  }

  void updateSupplier(Contact? supplier) async {
    if (supplier == null) {
      emit(state.copyWith(supplier: supplier));
      return;
    }

    var failureOrCategories = await getCategoriesUseCase.execute(NoParams());
    failureOrCategories.fold(
      (l) => emit(state.copyWith(formStatus: FormStatus.failed)),
      (r) => emit(state.copyWith(categories: r, supplier: supplier)),
    );
  }

  void updateCategory(Category? category) async {
    var failureOrItems = await getProductsUseCase
        .execute(GetProductsParams(categoryId: category?.id));
    failureOrItems.fold(
      (l) => emit(state.copyWith(formStatus: FormStatus.failed)),
      (r) => emit(
          state.copyWith(category: category, items: r, product: () => null)),
    );
  }

  void updateProduct(Product? product) {
    emit(state.copyWith(product: () => product));
  }

  // Method to update quantity
  void updateQuantity(String value) {
    int? quantity = int.tryParse(value);
    emit(state.copyWith(quantity: quantity));
  }
}
