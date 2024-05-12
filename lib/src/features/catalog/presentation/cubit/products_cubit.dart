import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/delete_product_usecase.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/get_products_use_case.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contact_usecase.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_categories_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase getProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetContactUseCase getContactUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final HomeBloc? homeBloc;

  ProductsCubit({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
    required this.getContactUseCase,
    required this.deleteProductUseCase,
    this.homeBloc,
  }) : super(ProductsInitial());

  void loadSupplierProducts(int supplierId) async {
    emit(ProductsLoading());

    final products = await getProductsUseCase.execute(
      GetProductsParams(supplierId: supplierId),
    );
    final categories = await getCategoriesUseCase.execute(NoParams());
    final supplier = await getContactUseCase.execute(
      GetContactParams(id: supplierId),
    );

    products.fold(
      (l) => emit(ProductsError(failure: l)),
      (prod) {
        categories.fold(
          (l) => emit(ProductsError(failure: l)),
          (cat) {
            supplier.fold(
              (l) => emit(ProductsError(failure: l)),
              (sup) {
                emit(ProductsLoaded(
                  products: prod,
                  categories: cat,
                  supplier: sup,
                ));
              },
            );
          },
        );
      },
    );
  }

  deleteProduct(int id, int supplierId) async {
    var response =
        await deleteProductUseCase.execute(DeleteProductParams(id: id));

    response.fold(
      (failure) => homeBloc?.add(
        ShowMessageEvent(
          message: "Product couldn't be deleted: ${failure.message}",
          type: AlertType.error,
        ),
      ),
      (_) {
        loadSupplierProducts(supplierId);
        homeBloc?.add(
          ShowMessageEvent(
              message: "Product has been deleted!", type: AlertType.success),
        );
      },
    );
  }

  deleteProducts() async {
    if (state is! ProductsLoaded) return;

    var selectedProducts = (state as ProductsLoaded).selectedProducts;
    var supplierId = (state as ProductsLoaded).supplier.id!;

    for (var product in selectedProducts) {
      var response = await deleteProductUseCase
          .execute(DeleteProductParams(id: product.id!));

      response.fold(
        (failure) => homeBloc?.add(
          ShowMessageEvent(
            message: "Products couldn't be deleted: ${failure.message}",
            type: AlertType.error,
          ),
        ),
        (_) {
          loadSupplierProducts(supplierId);
          homeBloc?.add(
            ShowMessageEvent(
              message: "Products have been deleted!",
              type: AlertType.success,
            ),
          );
        },
      );
    }
  }

  toggleSelectedProduct(Product product) {
    if (state is! ProductsLoaded) return;

    List<Product> selectedProducts =
        (state as ProductsLoaded).selectedProducts.toList();

    if (selectedProducts.contains(product)) {
      selectedProducts.remove(product);
    } else {
      selectedProducts.add(product);
    }

    emit(
        (state as ProductsLoaded).copyWith(selectedProducts: selectedProducts));
  }

  selectProductsByCategory(int categoryId) {
    if (state is! ProductsLoaded) return;

    List<Product> products = (state as ProductsLoaded).products;
    List<Product> selectedProducts =
        (state as ProductsLoaded).selectedProducts.toList();

    bool selected =
        !_checkIfCategorySelected(categoryId, selectedProducts, products);

    var productsOfCategory =
        products.where((product) => product.category == categoryId);

    for (var product in productsOfCategory) {
      if (selectedProducts.contains(product)) {
        if (!selected) {
          selectedProducts.remove(product);
        }
      } else {
        if (selected) {
          selectedProducts.add(product);
        }
      }
    }

    emit((state as ProductsLoaded).copyWith(
      selectedProducts: selectedProducts,
    ));
  }

  bool _checkIfCategorySelected(int categoryId, List<Product> selectedProducts,
      List<Product> allProducts) {
    var productsOfCategory =
        allProducts.where((product) => product.category == categoryId);

    if (productsOfCategory.every(
        (categoryProduct) => selectedProducts.contains(categoryProduct))) {
      return true;
    }
    return false;
  }
}
