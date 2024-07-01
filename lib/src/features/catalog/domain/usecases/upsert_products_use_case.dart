import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class UpsertProductsUseCase extends UseCase<void, UpsertProductsParams> {
  final ProductsRepository repository;

  UpsertProductsUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> execute(UpsertProductsParams params) {
    return repository.upsertProducts(params.products);
  }
}

class UpsertProductsParams {
  final List<Product> products;

  UpsertProductsParams({required this.products});
}
