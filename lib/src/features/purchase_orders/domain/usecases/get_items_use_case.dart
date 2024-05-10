import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/item_repository.dart';
import 'package:dartz/dartz.dart';

class GetItemsUseCase implements UseCase<List<Item>, GetItemsParams> {
  final ItemsRepository repository;

  GetItemsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Item>>> execute(params) {
    if (params.categoryId != null) {
      return repository.getItemsByCategory(params.categoryId!);
    }
    return repository.getItems(params.jobId);
  }
}

class GetItemsParams {
  final int jobId;
  final int? categoryId;

  GetItemsParams({required this.jobId, this.categoryId});
}
