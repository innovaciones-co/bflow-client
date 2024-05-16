import 'package:bflow_client/src/core/exceptions/bad_request_exception.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

import '../sources/categories_remote_data_source.dart';

class CategoriesRepositoryImp implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;
  CategoriesRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      return Right(await remoteDataSource.fetchCategories());
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Category>> createCategory(Category category) async {
    try {
      return Right(await remoteDataSource.createCategory(category));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    try {
      return Right(await remoteDataSource.deleteCategory(id));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Category>> getCategory(int id) async {
    try {
      return Right(await remoteDataSource.fetchCategory(id));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategoriesBySupplier(
      int supplierId) async {
    try {
      var categories = await remoteDataSource.fetchCategories();
      return Right(categories
          .where((element) => element.tradeCode == supplierId)
          .toList());
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Category>> update(Category category) async {
    try {
      return Right(await remoteDataSource.updateCategory(category));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }
}
