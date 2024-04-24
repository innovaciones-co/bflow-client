// ignore_for_file: unused_import

import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductsUseCase implements UseCase<List<Product>, GetProductsParams> {
  final ProductsRepository repository;

  GetProductsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> execute(params) {
    if (params.categoryId != null) {
      return repository.getProducts(params.categoryId!);
    }
    return repository.getProducts(null);
  }
}

class GetProductsParams {
  final int? categoryId;

  GetProductsParams({this.categoryId});
}
