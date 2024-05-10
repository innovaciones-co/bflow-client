import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/category_repository.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/item_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';

class CreateItemUseCase implements UseCase<Item, CreateItemParams> {
  final ItemsRepository repository;
  final CategoriesRepository categoriesRepository;

  CreateItemUseCase(
      {required this.repository, required this.categoriesRepository});

  @override
  Future<Either<Failure, Item>> execute(params) async {
    Product product = params.item;

    var failureOrcategory =
        await categoriesRepository.getCategory(product.category);

    return failureOrcategory.fold((failure) => Left(failure), (category) {
      Item item = Item(
        name: product.name,
        description: product.description,
        supplier: category.tradeCode,
        category: product.category,
        job: params.jobId,
        unitPrice: product.unitPrice,
        measure: product.unitOfMeasure,
        //vat: product.vat,
        units: params.quantity,
      );
      return repository.createItem(item);
    });
  }
}

class CreateItemParams {
  final Product item;
  final int jobId;
  final int quantity;

  CreateItemParams({
    required this.jobId,
    required this.item,
    required this.quantity,
  });
}
