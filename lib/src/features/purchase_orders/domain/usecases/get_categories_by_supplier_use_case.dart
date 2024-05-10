import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoriesBySupplierUseCase
    implements UseCase<List<Category>, GetCategoriesBySupplierParams> {
  final CategoriesRepository repository;

  GetCategoriesBySupplierUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Category>>> execute(params) {
    return repository.getCategoriesBySupplier(params.supplierId);
  }
}

class GetCategoriesBySupplierParams {
  final int supplierId;

  GetCategoriesBySupplierParams({required this.supplierId});
}
