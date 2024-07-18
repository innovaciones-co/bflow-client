import 'package:bflow_client/src/features/catalog/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecases/usecases.dart';

class GetCategoryUseCase implements UseCase<Category, GetCategoryParams> {
  final CategoriesRepository repository;

  GetCategoryUseCase({required this.repository});

  @override
  Future<Either<Failure, Category>> execute(params) {
    return repository.getCategory(params.id);
  }
}

class GetCategoryParams {
  final int id;

  GetCategoryParams({required this.id});
}
