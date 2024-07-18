import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/catalog/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteProductUseCase implements UseCase<void, DeleteProductParams> {
  final ProductsRepository repository;

  DeleteProductUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(DeleteProductParams params) {
    return repository.deleteProduct(params.id);
  }
}

class DeleteProductParams {
  final int id;

  DeleteProductParams({required this.id});
}
