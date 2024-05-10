import 'package:bflow_client/src/core/exceptions/bad_request_exception.dart';
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
  Future<Either<Failure, List<Product>>> getProducts(
      int? categoryId, int? supplierId) async {
    try {
      return Right(
          await remoteDataSource.fetchProducts(categoryId, supplierId));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(int productId) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int productId) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    try {
      return Right(await remoteDataSource.createProduct(product));
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
  Future<Either<Failure, Product>> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
