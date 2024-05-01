import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getProducts(int? categoryId);
}
