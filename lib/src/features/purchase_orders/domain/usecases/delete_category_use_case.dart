import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';

class DeleteCategoryUseCase implements UseCase<void, DeleteCategoryParams> {
  final CategoriesRepository repository;

  DeleteCategoryUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(params) {
    return repository.delete(params.id);
  }
}

class DeleteCategoryParams {
  final int id;

  DeleteCategoryParams({required this.id});
}
