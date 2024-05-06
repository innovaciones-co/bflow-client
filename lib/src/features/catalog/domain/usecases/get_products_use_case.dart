// ignore_for_file: unused_import

import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductsUseCase implements UseCase<List<Product>, GetProductsParams> {
  final ProductsRepository repository;

  GetProductsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> execute(GetProductsParams params) {
    if (params.categoryId != null) {
      return repository.getProductsByCategory(params.categoryId!);
    }
    if (params.supplierId != null) {
      return repository.getProductsBySupplier(params.supplierId!);
    }
    return repository.getProducts();
  }
}

class GetProductsParams {
  final int? categoryId;
  final int? supplierId;

  GetProductsParams({this.categoryId, this.supplierId});
}
