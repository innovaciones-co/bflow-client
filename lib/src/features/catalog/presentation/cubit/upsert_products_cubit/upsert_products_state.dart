part of 'upsert_products_cubit.dart';

sealed class UpsertProductsState extends Equatable {
  const UpsertProductsState();

  @override
  List<Object> get props => [];
}

final class UpsertProductsInitial extends UpsertProductsState {}

final class UpsertProductsLoadInProgress extends UpsertProductsState {
  final String message;

  const UpsertProductsLoadInProgress({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class UpsertProductsLoadSuccess extends UpsertProductsState {}

final class UpsertProductsLoadFailure extends UpsertProductsState {
  final String message;

  const UpsertProductsLoadFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
