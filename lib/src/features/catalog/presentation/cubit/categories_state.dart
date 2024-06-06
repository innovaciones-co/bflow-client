part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;

  const CategoriesLoaded({
    required this.categories,
  });

  CategoriesLoaded copyWith({
    List<Category>? categories,
  }) {
    return CategoriesLoaded(
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [
        categories,
      ];
}

class CategoriesError extends CategoriesState {
  final Failure failure;

  const CategoriesError({required this.failure});

  @override
  List<Object> get props => [failure];
}