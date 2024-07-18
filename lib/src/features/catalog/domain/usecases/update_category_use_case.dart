import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';

class UpdateCategoryUseCase implements UseCase<Category, UpdateCategoryParams> {
  final CategoriesRepository repository;

  UpdateCategoryUseCase({required this.repository});

  @override
  Future<Either<Failure, Category>> execute(params) async {
    var category = await repository.update(params.category);
    return category;
  }
}

class UpdateCategoryParams {
  final Category category;

  UpdateCategoryParams({required this.category});
}
