import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoriesUseCase implements UseCase<List<Category>, NoParams> {
  final CategoriesRepository repository;

  GetCategoriesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Category>>> execute(params) {
    return repository.getCategories();
  }
}
