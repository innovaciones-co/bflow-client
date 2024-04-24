import 'package:bflow_client/src/core/exceptions/bad_request_exception.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/item_repository.dart';
import 'package:dartz/dartz.dart';

import '../sources/items_remote_data_source.dart';

class ItemsRepositoryImp implements ItemsRepository {
  final ItemsRemoteDataSource remoteDataSource;
  ItemsRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Item>>> getItems(int jobId) async {
    try {
      return Right(await remoteDataSource.fetchItemsByJob(jobId));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Item>> createItem(Item item) async {
    try {
      return Right(await remoteDataSource.createItem(item));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteItem(int id) async {
    try {
      return Right(await remoteDataSource.deleteItem(id));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(
        ClientFailure(
          message: e.toString(),
          errorResponse: e.errorResponse,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Item>> getItem(int id) async {
    try {
      return Right(await remoteDataSource.fetchItem(id));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Item>> update(Item item) async {
    try {
      return Right(await remoteDataSource.updateItem(item));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PurchaseOrder>>> createPurchaseOrder(
      List<Item> items) {
    // TODO: implement createPurchaseOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Item>>> getItemsByCategory(int categoryId) async {
    try {
      return Right(await remoteDataSource.fetchItemsByCategory(categoryId));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
