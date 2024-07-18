import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';

class CreateCategoryUseCase implements UseCase<Category, CreateCategoryParams> {
  final CategoriesRepository repository;

  CreateCategoryUseCase({required this.repository});

  @override
  Future<Either<Failure, Category>> execute(params) async {
    var category = await repository.createCategory(params.category);
    return category;
  }
}

class CreateCategoryParams {
  final Category category;

  CreateCategoryParams({required this.category});
}
