import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';

class SendPurchaseOrdersUseCase
    implements UseCase<List<PurchaseOrder>, SendPurchaseOrdersParams> {
  final PurchaseOrdersRepository repository;

  SendPurchaseOrdersUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PurchaseOrder>>> execute(params) async {
    var purchaseOrders =
        await repository.sendPurchaseOrders(params.purchaseOrders);
    return purchaseOrders;
  }
}

class SendPurchaseOrdersParams {
  final List<PurchaseOrder> purchaseOrders;

  SendPurchaseOrdersParams({required this.purchaseOrders});
}
