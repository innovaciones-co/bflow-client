part of 'write_item_cubit.dart';

sealed class WriteItemState extends Equatable {
  final FormStatus formStatus;
  final Failure? failure;
  final AutovalidateMode autovalidateMode;
  final List<Contact> suppliers;
  final List<Category> categories;
  final List<Product> items;
  final Contact? supplier;
  final Category? category;
  final Product? product;
  final int quantity;

  const WriteItemState({
    this.formStatus = FormStatus.initialized,
    this.failure,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.suppliers = const [],
    this.categories = const [],
    this.items = const [],
    this.category,
    this.supplier,
    this.product,
    this.quantity = 0,
  });

  WriteItemValidator copyWith({
    FormStatus? formStatus,
    Failure? failure,
    AutovalidateMode? autovalidateMode,
    List<Contact>? suppliers,
    List<Category>? categories,
    List<Product>? items,
    Contact? Function()? supplier,
    Category? Function()? category,
    Product? Function()? product,
    int? quantity,
  });

  @override
  List<Object> get props => [
        autovalidateMode,
        failure ?? "",
        formStatus,
        suppliers,
        categories,
        items,
        category ?? "",
        supplier ?? "",
        product ?? "",
        quantity
      ];
}

final class WriteItemValidator extends WriteItemState {
  const WriteItemValidator({
    super.formStatus,
    super.failure,
    super.autovalidateMode,
    super.suppliers,
    super.categories,
    super.items,
    super.category,
    super.supplier,
    super.product,
    super.quantity,
  });

  @override
  WriteItemValidator copyWith({
    FormStatus? formStatus,
    Failure? failure,
    AutovalidateMode? autovalidateMode,
    List<Contact>? suppliers,
    List<Category>? categories,
    List<Product>? items,
    Contact? Function()? supplier,
    Category? Function()? category,
    Product? Function()? product,
    int? quantity,
  }) {
    return WriteItemValidator(
      formStatus: formStatus ?? this.formStatus,
      failure: failure ?? this.failure,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      suppliers: suppliers ?? this.suppliers,
      categories: categories ?? this.categories,
      items: items ?? this.items,
      category: category == null ? this.category : category(),
      supplier: supplier == null ? this.supplier : supplier(),
      product: product == null ? this.product : product(),
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [
        autovalidateMode,
        failure ?? "",
        formStatus,
        suppliers,
        categories,
        items,
        category ?? "",
        supplier ?? "",
        product ?? "",
        quantity
      ];
}
