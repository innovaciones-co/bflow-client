import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

class GetPurchaseOrdersByJobUseCase
    implements UseCase<List<PurchaseOrder>, GetPurchaseOrdersByJobParams> {
  final PurchaseOrdersRepository repository;

  GetPurchaseOrdersByJobUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PurchaseOrder>>> execute(params) {
    return repository.getPurchaseOrdersByJob(params.jobId);
  }
}

class GetPurchaseOrdersByJobParams {
  final int jobId;

  GetPurchaseOrdersByJobParams({required this.jobId});
}
