import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProductUseCase implements UseCase<Product, UpdateProductParams> {
  final ProductsRepository repository;

  UpdateProductUseCase({required this.repository});

  @override
  Future<Either<Failure, Product>> execute(UpdateProductParams params) {
    return repository.updateProduct(params.product);
  }
}

class UpdateProductParams {
  final Product product;

  UpdateProductParams({required this.product});
}
