part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final List<Category> categories;
  final Contact supplier;
  final List<Product> selectedProducts;
  final List<int> selectedCategories;

  const ProductsLoaded({
    required this.products,
    required this.categories,
    required this.supplier,
    this.selectedProducts = const [],
    this.selectedCategories = const [],
  });

  ProductsLoaded copyWith({
    List<Product>? products,
    List<Category>? categories,
    Contact? supplier,
    List<Product>? selectedProducts,
    List<int>? selectedCategories,
  }) {
    return ProductsLoaded(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      supplier: supplier ?? this.supplier,
      selectedProducts: selectedProducts ?? this.selectedProducts,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  @override
  List<Object> get props => [
        products,
        categories,
        supplier,
        selectedProducts,
        selectedCategories,
      ];
}

class ProductsError extends ProductsState {
  final Failure failure;

  const ProductsError({required this.failure});

  @override
  List<Object> get props => [failure];
}

class ToggleSelectedProduct extends ProductsState {
  final Product product;

  const ToggleSelectedProduct({required this.product});
}
