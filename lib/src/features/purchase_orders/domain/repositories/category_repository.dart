import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, Category>> getCategory(int id);
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<Category>>> getCategoriesBySupplier(
      int suplierId);
  Future<Either<Failure, Category>> createCategory(Category category);
  Future<Either<Failure, Category>> update(Category category);
  Future<Either<Failure, void>> delete(int id);
}
