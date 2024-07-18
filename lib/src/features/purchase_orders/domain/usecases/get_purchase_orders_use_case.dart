import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

class GetPurchaseOrdersUseCase
    implements UseCase<List<PurchaseOrder>, NoParams> {
  final PurchaseOrdersRepository repository;

  GetPurchaseOrdersUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PurchaseOrder>>> execute(params) {
    return repository.getPurchaseOrders();
  }
}
