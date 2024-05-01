import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/purchase_orders/data/sources/products_remote_data_source.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductsRepositoryImp implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts(int? categoryId) async {
    try {
      return Right(await remoteDataSource.fetchProducts(categoryId));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
