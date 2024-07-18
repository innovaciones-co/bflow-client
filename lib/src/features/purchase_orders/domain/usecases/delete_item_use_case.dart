import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/item_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';

class DeleteItemUseCase implements UseCase<void, DeleteItemParams> {
  final ItemsRepository repository;

  DeleteItemUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(params) {
    return repository.deleteItem(params.id);
  }
}

class DeleteItemParams {
  final int id;

  DeleteItemParams({required this.id});
}
