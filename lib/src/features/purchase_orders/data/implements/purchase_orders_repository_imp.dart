import 'package:bflow_client/src/core/exceptions/bad_request_exception.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/purchase_orders/data/sources/purchase_orders_remote_data_source.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

class PurchaseOrdersRepositoryImp implements PurchaseOrdersRepository {
  final PurchaseOrdersRemoteDataSource remoteDataSource;
  PurchaseOrdersRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PurchaseOrder>>> getPurchaseOrders() async {
    try {
      return Right(await remoteDataSource.fetchPurchaseOrders());
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, PurchaseOrder>> getPurchaseOrder(int id) async {
    try {
      return Right(await remoteDataSource.fetchPurchaseOrder(id));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<PurchaseOrder>>> sendPurchaseOrders(
      List<PurchaseOrder> purchaseOrders) {
    // TODO: implement sendPurchaseOrders
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PurchaseOrder>>> getPurchaseOrdersByJob(
      int jobId) async {
    try {
      return Right(await remoteDataSource.fetchPurchaseOrdersByJob(jobId));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<PurchaseOrder>>> createPurchaseOrderFromItems(
      {required int jobId, required List<Item> items}) async {
    try {
      return Right(
          await remoteDataSource.createPurchaseOrderFromItems(jobId, items));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }
}
