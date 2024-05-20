part of 'write_category_cubit.dart';

sealed class WriteCategoryState extends Equatable {
  final int? id;
  final int? tradeCode;
  final String? name;
  final int? supplier;
  final Failure? failure;
  final FormStatus formStatus;
  final AutovalidateMode? autovalidateMode;

  WriteCategoryState({
    this.id,
    this.tradeCode,
    this.name,
    this.supplier,
    this.failure,
    this.formStatus = FormStatus.initialized,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  WriteCategoryState copyWith({
    int? id,
    int? tradeCode,
    String? name,
    int? supplier,
    Failure? failure,
    FormStatus? formStatus,
    AutovalidateMode? autovalidateMode,
  });

  @override
  List<Object?> get props => [
        id,
        tradeCode,
        name,
        supplier,
        failure,
        formStatus,
        autovalidateMode,
      ];
}

final class WriteCategoryValidator extends WriteCategoryState {
  WriteCategoryValidator({
    super.id,
    super.tradeCode,
    super.name,
    super.supplier,
    super.failure,
    super.formStatus = FormStatus.initialized,
    super.autovalidateMode = AutovalidateMode.disabled,
  });

  @override
  WriteCategoryState copyWith({
    int? id,
    int? tradeCode,
    String? name,
    int? supplier,
    Failure? failure,
    FormStatus? formStatus,
    AutovalidateMode? autovalidateMode,
  }) {
    return WriteCategoryValidator(
      id: id ?? this.id,
      tradeCode: tradeCode ?? this.tradeCode,
      name: name ?? this.name,
      supplier: supplier ?? this.supplier,
      failure: failure ?? this.failure,
      formStatus: formStatus ?? this.formStatus,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
    );
  }
}
