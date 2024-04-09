import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/item_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';

class CreateItemUseCase implements UseCase<Item, CreateItemParams> {
  final ItemsRepository repository;

  CreateItemUseCase({required this.repository});

  @override
  Future<Either<Failure, Item>> execute(params) async {
    var item = await repository.createItem(params.item);
    return item;
  }
}

class CreateItemParams {
  final Item item;

  CreateItemParams({required this.item});
}
