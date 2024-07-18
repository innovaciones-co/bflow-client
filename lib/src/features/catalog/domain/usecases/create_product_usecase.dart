import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class CreateProductUseCase implements UseCase<Product, CreateProductParams> {
  final ProductsRepository repository;

  CreateProductUseCase({required this.repository});

  @override
  Future<Either<Failure, Product>> execute(CreateProductParams params) {
    return repository.createProduct(params.product);
  }
}

class CreateProductParams {
  final Product product;

  CreateProductParams({required this.product});
}
