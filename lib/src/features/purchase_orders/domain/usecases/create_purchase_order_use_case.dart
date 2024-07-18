import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';

class CreatePurchaseOrderUseCase
    implements UseCase<List<PurchaseOrder>, CreatePurchaseOrderParams> {
  final PurchaseOrdersRepository repository;

  CreatePurchaseOrderUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PurchaseOrder>>> execute(params) async {
    var purchaseOrders = await repository.createPurchaseOrderFromItems(
        jobId: params.jobId, items: params.items);
    return purchaseOrders;
  }
}

class CreatePurchaseOrderParams {
  final List<Item> items;
  final int jobId;

  CreatePurchaseOrderParams({required this.jobId, required this.items});
}
