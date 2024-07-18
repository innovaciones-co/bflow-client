import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/delete_category_use_case.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/get_categories_use_case.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final HomeBloc? homeBloc;

  CategoriesCubit({
    required this.getCategoriesUseCase,
    required this.deleteCategoryUseCase,
    this.homeBloc,
  }) : super(CategoriesInitial());

  void loadCategories() async {
    emit(CategoriesLoading());
    final categoriesOrFailure = await getCategoriesUseCase.execute(NoParams());

    categoriesOrFailure.fold(
      (l) => emit(CategoriesError(failure: l)),
      (cat) => emit(CategoriesLoaded(categories: cat)),
    );
  }

  deleteCategory(int id) async {
    var response =
        await deleteCategoryUseCase.execute(DeleteCategoryParams(id: id));

    response.fold(
      (failure) => homeBloc?.add(
        ShowMessageEvent(
          message: "Category couldn't be deleted: ${failure.message}",
          type: AlertType.error,
        ),
      ),
      (_) {
        loadCategories();
        homeBloc?.add(
          ShowMessageEvent(
            message: "Category has been deleted!",
            type: AlertType.success,
          ),
        );
      },
    );
  }
}
