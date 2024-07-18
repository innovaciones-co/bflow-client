import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PurchaseOrdersRepository {
  Future<Either<Failure, PurchaseOrder>> getPurchaseOrder(int id);
  Future<Either<Failure, List<PurchaseOrder>>> getPurchaseOrders();
  Future<Either<Failure, List<PurchaseOrder>>> getPurchaseOrdersByJob(
      int jobId);
  Future<Either<Failure, List<PurchaseOrder>>> sendPurchaseOrders(
    List<PurchaseOrder> purchaseOrders,
  );
  Future<Either<Failure, List<PurchaseOrder>>> createPurchaseOrderFromItems(
      {required int jobId, required List<Item> items});
}
