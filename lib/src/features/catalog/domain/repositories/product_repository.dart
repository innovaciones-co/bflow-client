import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getProducts(
      int? categoryId, int? supplierId);
  Future<Either<Failure, Product>> getProduct(int productId);
  Future<Either<Failure, Product>> createProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(int productId);
  Future<Either<Failure, void>> upsertProducts(List<Product> products);
}
