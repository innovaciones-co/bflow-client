import 'package:bflow_client/src/core/exceptions/type_mismatch_exception.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/upsert_products_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upsert_products_state.dart';

class UpsertProductsCubit extends Cubit<UpsertProductsState> {
  final UpsertProductsUseCase upsertProductsUseCase;

  UpsertProductsCubit({
    required this.upsertProductsUseCase,
  }) : super(UpsertProductsInitial());

  void loadProductsData(List<int>? file) {
    if (file == null) return;

    emit(const UpsertProductsLoadInProgress(message: 'Reading file...'));
    Excel excel = Excel.decodeBytes(file);

    emit(const UpsertProductsLoadInProgress(message: 'Validating data...'));

    var categoriesSheet = excel.tables['Categories'];
    if (categoriesSheet == null) {
      emit(const UpsertProductsLoadFailure(
          message: 'Categories sheet missing!'));
      return;
    }
    var productsSheet = excel.tables['Products'];
    if (productsSheet == null) {
      emit(const UpsertProductsLoadFailure(message: 'Products sheet missing!'));
      return;
    }

    try {
      for (int i = 1; i < productsSheet.maxRows; i++) {
        String nameCell = _getValueFromCell(
          sheet: productsSheet,
          expectedType: String,
          rowIndex: i,
          columnIndex: 0,
        );
        String skuCell = _getValueFromCell(
          sheet: productsSheet,
          expectedType: String,
          rowIndex: i,
          columnIndex: 1,
        );
        String? descriptionCell = _getValueFromCell(
          sheet: productsSheet,
          expectedType: String,
          rowIndex: i,
          columnIndex: 2,
        );
        double unitPriceCell = _getValueFromCell(
          sheet: productsSheet,
          expectedType: double,
          rowIndex: i,
          columnIndex: 3,
        );
        int? gtsCell = _getValueFromCell(
          sheet: productsSheet,
          expectedType: int,
          rowIndex: i,
          columnIndex: 4,
        );
        String unitOfMeasureCell = _getValueFromCell(
          sheet: productsSheet,
          expectedType: String,
          rowIndex: i,
          columnIndex: 5,
        ); // TODO: type Unit
        int? uomOrderIncrement = _getValueFromCell(
          sheet: productsSheet,
          expectedType: int,
          rowIndex: i,
          columnIndex: 6,
        );
        String? urlCell = _getValueFromCell(
          sheet: productsSheet,
          expectedType: String,
          rowIndex: i,
          columnIndex: 7,
        );
        String categoryCell = _getValueFromCell(
          sheet: productsSheet,
          expectedType: String,
          rowIndex: i,
          columnIndex: 8,
        ); // TODO: type int
      }
    } on TypeMismatchException catch (e) {
      emit(UpsertProductsLoadFailure(message: e.toString()));
    }

    for (int i = 1; i < categoriesSheet.maxRows; i++) {
      String tradeCodeCell = _getValueFromCell(
        sheet: categoriesSheet,
        expectedType: String,
        rowIndex: i,
        columnIndex: 0,
      );
      String nameCell = _getValueFromCell(
        sheet: categoriesSheet,
        expectedType: String,
        rowIndex: i,
        columnIndex: 1,
      );
    }
    //emit(const UpsertProductsLoadInProgress(message: 'Done!'));
  }

  dynamic _getValueFromCell({
    Sheet? sheet,
    required Type expectedType,
    required int rowIndex,
    required int columnIndex,
  }) {
    dynamic value;

    CellValue? cellValue = sheet!
        .cell(CellIndex.indexByColumnRow(
            columnIndex: columnIndex, rowIndex: rowIndex))
        .value;

    switch (cellValue) {
      case null:
        value = null;
        break;
      case TextCellValue():
        value = cellValue.value;
        break;
      case IntCellValue():
        if (expectedType == double) {
          value = cellValue.value.toDouble() /
              1.0; // TODO: Fix, it is returning an int
          print('Type: ${value.runtimeType}');
        } else {
          value = cellValue.value;
        }
        break;
      case DoubleCellValue():
        value = cellValue.value;
        break;
      default:
        value = null;
        break;
    }

    if (value != null && value.runtimeType != expectedType) {
      throw TypeMismatchException(
          "${sheet.sheetName} sheet - Expected type $expectedType but got ${value.runtimeType}: row ${rowIndex + 1}, column ${columnIndex + 1}");
    }

    return value;
  }
}
