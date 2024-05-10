import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/item_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';

class UpdateItemUseCase implements UseCase<Item, UpdateItemParams> {
  final ItemsRepository repository;

  UpdateItemUseCase({required this.repository});

  @override
  Future<Either<Failure, Item>> execute(params) async {
    var item = await repository.update(params.item);
    return item;
  }
}

class UpdateItemParams {
  final Item item;

  UpdateItemParams({required this.item});
}
