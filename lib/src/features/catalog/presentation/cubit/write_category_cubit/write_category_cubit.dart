import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/create_category_use_case.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/update_category_use_case.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/categories_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'write_category_state.dart';

class WriteCategoryCubit extends Cubit<WriteCategoryState> {
  final CategoriesCubit categoriesCubit;
  final CreateCategoryUseCase createCategorytUseCase;
  final UpdateCategoryUseCase updateCategorytUseCase;

  WriteCategoryCubit({
    required this.categoriesCubit,
    required this.createCategorytUseCase,
    required this.updateCategorytUseCase,
  }) : super(WriteCategoryValidator());

  void initForm({
    final int? id,
    final int tradeCode = 0,
    final String name = '',
  }) {
    emit(state.copyWith(
      id: id,
      tradeCode: tradeCode,
      name: name,
    ));
  }

  void initFormFromCategory(Category? category) {
    if (category == null) return;
    initForm(
      id: category.id,
      tradeCode: category.tradeCode,
      name: category.name,
    );
  }

  Future<void> createCategory() async {
    emit(state.copyWith(formStatus: FormStatus.inProgress));

    Category category = Category(
      name: state.name!,
      tradeCode: state.tradeCode!,
    );

    final failureOrCategory = await createCategorytUseCase.execute(
      CreateCategoryParams(category: category),
    );

    failureOrCategory.fold(
      (failure) =>
          emit(state.copyWith(failure: failure, formStatus: FormStatus.failed)),
      (contact) {
        emit(state.copyWith(formStatus: FormStatus.success));
        categoriesCubit.loadCategories();
      },
    );
  }

  Future<void> updateCategory() async {
    emit(state.copyWith(formStatus: FormStatus.inProgress));

    Category category = Category(
      id: state.id,
      name: state.name!,
      tradeCode: state.tradeCode!,
    );

    final failureOrCategory = await updateCategorytUseCase.execute(
      UpdateCategoryParams(category: category),
    );

    failureOrCategory.fold(
      (failure) =>
          emit(state.copyWith(failure: failure, formStatus: FormStatus.failed)),
      (contact) {
        emit(state.copyWith(formStatus: FormStatus.success));
        categoriesCubit.loadCategories();
      },
    );
  }

  void updateTradeCode(String? tradeCode) {
    emit(state.copyWith(
        tradeCode: tradeCode != null ? int.tryParse(tradeCode) : null));
  }

  void updateName(String? name) {
    emit(state.copyWith(name: name));
  }

  void updateAutovalidateMode(AutovalidateMode? autovalidateMode) {
    emit(state.copyWith(autovalidateMode: autovalidateMode));
  }
}
