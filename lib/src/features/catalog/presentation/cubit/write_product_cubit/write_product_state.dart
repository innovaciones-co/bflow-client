part of 'write_product_cubit.dart';

abstract class WriteProductState extends Equatable {
  final int? id;
  final String? name;
  final String? sku;
  final String? description;
  final double? unitPrice;
  final double? vat;
  final Unit? unitOfMeasure;
  final double? uomOrderIncrement;
  final String? url;
  final int? category;
  final int? supplier;
  final List<Category> categories;
  final Failure? failure;
  final FormStatus formStatus;
  final AutovalidateMode? autovalidateMode;

  const WriteProductState({
    this.id,
    this.name,
    this.sku,
    this.description,
    this.unitPrice,
    this.vat,
    this.unitOfMeasure,
    this.uomOrderIncrement,
    this.url,
    this.category,
    this.supplier,
    this.categories = const [],
    this.failure,
    this.formStatus = FormStatus.initialized,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  WriteProductState copyWith({
    int? id,
    String? name,
    String? sku,
    String? description,
    double? unitPrice,
    double? vat,
    Unit? unitOfMeasure,
    double? uomOrderIncrement,
    String? url,
    int? category,
    int? supplier,
    List<Category>? categories,
    Failure? failure,
    FormStatus? formStatus,
    AutovalidateMode? autovalidateMode,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        sku,
        description,
        unitPrice,
        vat,
        unitOfMeasure,
        uomOrderIncrement,
        url,
        category,
        supplier,
        categories,
        failure,
        formStatus,
        autovalidateMode,
      ];
}

final class WriteProductValidator extends WriteProductState {
  const WriteProductValidator({
    super.id,
    super.name = '',
    super.sku = '',
    super.description = '',
    super.unitPrice,
    super.vat,
    super.unitOfMeasure,
    super.uomOrderIncrement,
    super.url = '',
    super.category,
    super.supplier,
    super.categories,
    super.failure,
    super.formStatus = FormStatus.initialized,
    super.autovalidateMode = AutovalidateMode.disabled,
  });

  @override
  WriteProductState copyWith({
    int? id,
    String? name,
    String? sku,
    String? description,
    double? unitPrice,
    double? vat,
    Unit? unitOfMeasure,
    double? uomOrderIncrement,
    String? url,
    int? category,
    int? supplier,
    List<Category>? categories,
    Failure? failure,
    FormStatus? formStatus,
    AutovalidateMode? autovalidateMode,
  }) {
    return WriteProductValidator(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      description: description ?? this.description,
      unitPrice: unitPrice ?? this.unitPrice,
      vat: vat ?? this.vat,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
      uomOrderIncrement: uomOrderIncrement ?? this.uomOrderIncrement,
      url: url ?? this.url,
      category: category ?? this.category,
      supplier: supplier ?? this.supplier,
      categories: categories ?? this.categories,
      failure: failure ?? this.failure,
      formStatus: formStatus ?? this.formStatus,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
    );
  }
}
