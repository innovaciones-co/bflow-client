import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getProductsByCategory(int? categoryId);
  Future<Either<Failure, List<Product>>> getProductsBySupplier(int? supplierId);
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> saveProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(int productId);
}
