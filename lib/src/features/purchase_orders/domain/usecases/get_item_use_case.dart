import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/item_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecases/usecases.dart';

class GetItemUseCase implements UseCase<Item, GetItemParams> {
  final ItemsRepository repository;

  GetItemUseCase({required this.repository});

  @override
  Future<Either<Failure, Item>> execute(params) {
    return repository.getItem(params.id);
  }
}

class GetItemParams {
  final int id;

  GetItemParams({required this.id});
}
