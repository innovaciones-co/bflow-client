import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ItemsRepository {
  Future<Either<Failure, Item>> getItem(int id);
  Future<Either<Failure, List<Item>>> getItems(int jobId);
  Future<Either<Failure, List<Item>>> getItemsByCategory(int categoryId);
  Future<Either<Failure, Item>> createItem(Item item);

  Future<Either<Failure, Item>> update(Item item);
  Future<Either<Failure, void>> delete(int id);
}
