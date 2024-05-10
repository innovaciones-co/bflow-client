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

  const ProductsLoaded({
    required this.products,
    required this.categories,
    required this.supplier,
  });

  @override
  List<Object> get props => [
        products,
        categories,
        supplier,
      ];
}

class ProductsError extends ProductsState {
  final Failure failure;

  const ProductsError({required this.failure});

  @override
  List<Object> get props => [failure];
}
