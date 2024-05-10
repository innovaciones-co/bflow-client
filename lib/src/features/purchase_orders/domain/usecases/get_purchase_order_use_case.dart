import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecases/usecases.dart';

class GetPurchaseOrderUseCase
    implements UseCase<PurchaseOrder, GetPurchaseOrderParams> {
  final PurchaseOrdersRepository repository;

  GetPurchaseOrderUseCase({required this.repository});

  @override
  Future<Either<Failure, PurchaseOrder>> execute(params) {
    return repository.getPurchaseOrder(params.id);
  }
}

class GetPurchaseOrderParams {
  final int id;

  GetPurchaseOrderParams({required this.id});
}
