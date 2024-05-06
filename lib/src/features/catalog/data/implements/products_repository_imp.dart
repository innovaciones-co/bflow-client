import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/catalog/data/sources/products_remote_data_source.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductsRepositoryImp implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      int? categoryId) async {
    try {
      return Right(await remoteDataSource.fetchProducts(categoryId));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsBySupplier(
      int? supplierId) {
    // TODO: implement getProductsBySupplier
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int productId) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> saveProduct(Product product) {
    // TODO: implement saveProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
