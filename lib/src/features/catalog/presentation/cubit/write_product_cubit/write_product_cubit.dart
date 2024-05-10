import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/units.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/create_product_usecase.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/update_product_usecase.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/products_cubit.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_categories_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'write_product_state.dart';

class WriteProductCubit extends Cubit<WriteProductState> {
  final ProductsCubit productsCubit;
  final CreateProductUseCase createProductUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final UpdateProductUseCase updateProductUseCase;

  WriteProductCubit({
    required this.productsCubit,
    required this.createProductUseCase,
    required this.getCategoriesUseCase,
    required this.updateProductUseCase,
  }) : super(WriteProductValidator());

  Future<void> initForm({
    final int? id,
    final String name = '',
    final String sku = '',
    final String description = '',
    final double? unitPrice = 0.0,
    final int? vat,
    final Unit? unitOfMeasure,
    final int? uomOrderIncrement,
    final String? url = '',
    final int? category,
    final int? supplier,
  }) async {
    var failureOrContacts = await getCategoriesUseCase.execute(NoParams());
    failureOrContacts.fold(
      (l) => emit(state.copyWith(formStatus: FormStatus.failed)),
      (categories) => emit(
        state.copyWith(
          id: id,
          name: name,
          sku: sku,
          description: description,
          unitPrice: unitPrice,
          vat: vat,
          unitOfMeasure: unitOfMeasure,
          uomOrderIncrement: uomOrderIncrement,
          url: url,
          category: category,
          supplier: supplier,
          categories: categories,
          formStatus: FormStatus.loaded,
        ),
      ),
    );
  }

  void initFormFromProduct(Product? product, int? suppliedId) {
    if (product == null) {
      initForm(supplier: suppliedId);
      return;
    }
    initForm(
      id: product.id,
      name: product.name,
      sku: product.sku,
      description: product.description ?? '',
      unitPrice: product.unitPrice,
      vat: product.vat,
      unitOfMeasure: product.unitOfMeasure,
      uomOrderIncrement: product.uomOrderIncrement,
      url: product.url,
      category: product.category,
      supplier: product.supplier,
    );
  }

  Future<void> createProduct() async {
    emit(state.copyWith(formStatus: FormStatus.inProgress));

    Product product = Product(
      name: state.name!,
      sku: state.sku!,
      description: state.description,
      unitPrice: state.unitPrice!,
      vat: state.vat,
      unitOfMeasure: state.unitOfMeasure!,
      uomOrderIncrement: state.uomOrderIncrement,
      url: state.url,
      category: state.category!,
      supplier: state.supplier!,
    );

    final failureOrProduct = await createProductUseCase.execute(
      CreateProductParams(product: product),
    );

    failureOrProduct.fold(
      (failure) =>
          emit(state.copyWith(failure: failure, formStatus: FormStatus.failed)),
      (product) {
        emit(state.copyWith(formStatus: FormStatus.success));
        productsCubit.loadSupplierProducts(state.supplier!);
      },
    );
  }

  Future<void> updateProduct() async {
    emit(state.copyWith(formStatus: FormStatus.inProgress));

    Product product = Product(
      id: state.id,
      name: state.name!,
      sku: state.sku!,
      description: state.description,
      unitPrice: state.unitPrice!,
      vat: state.vat,
      unitOfMeasure: state.unitOfMeasure!,
      uomOrderIncrement: state.uomOrderIncrement,
      url: state.url,
      category: state.category!,
      supplier: state.supplier!,
    );

    final failureOrProduct = await updateProductUseCase.execute(
      UpdateProductParams(product: product),
    );

    failureOrProduct.fold(
      (failure) =>
          emit(state.copyWith(failure: failure, formStatus: FormStatus.failed)),
      (product) {
        emit(state.copyWith(formStatus: FormStatus.success));
        productsCubit.loadSupplierProducts(state.supplier!);
      },
    );
  }

  void updateCategory(Category? category) {
    emit(state.copyWith(category: category?.id));
  }

  void updateSku(String? sku) {
    emit(state.copyWith(sku: sku));
  }

  void updateName(String? name) {
    emit(state.copyWith(name: name));
  }

  void updateDescription(String? description) {
    emit(state.copyWith(description: description));
  }

  void updateUnitOfMeasure(Unit? unitOfMeasure) {
    emit(state.copyWith(unitOfMeasure: unitOfMeasure));
  }

  void updateUnitPrice(String? unitPrice) {
    emit(state.copyWith(
        unitPrice: unitPrice != null ? double.tryParse(unitPrice) : null));
  }

  void updateUrl(String? url) {
    emit(state.copyWith(url: url));
  }

  void updateAutovalidateMode(AutovalidateMode? autovalidateMode) {
    emit(state.copyWith(autovalidateMode: autovalidateMode));
  }
}
