import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/item_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';

class CreatePurchaseOrderUseCase
    implements UseCase<List<PurchaseOrder>, CreatePurchaseOrderParams> {
  final ItemsRepository repository;

  CreatePurchaseOrderUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PurchaseOrder>>> execute(params) async {
    var purchaseOrders = await repository.createPurchaseOrder(params.items);
    return purchaseOrders;
  }
}

class CreatePurchaseOrderParams {
  final List<Item> items;

  CreatePurchaseOrderParams({required this.items});
}
