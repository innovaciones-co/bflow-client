import 'package:bflow_client/src/core/exceptions/type_mismatch_exception.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/units.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/get_categories_use_case.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/upsert_products_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upsert_products_state.dart';

class UpsertProductsCubit extends Cubit<UpsertProductsState> {
  final UpsertProductsUseCase upsertProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  UpsertProductsCubit({
    required this.upsertProductsUseCase,
    required this.getCategoriesUseCase,
  }) : super(UpsertProductsInitial());

  Future<void> loadProductsData(List<int>? file) async {
    List<Product> products = [];

    if (file == null) return;

    emit(const UpsertProductsLoadInProgress(message: 'Reading file...'));
    Excel excel = Excel.decodeBytes(file);

    emit(const UpsertProductsLoadInProgress(message: 'Validating data...'));

    var productsSheet = excel.tables['Products'];
    if (productsSheet == null) {
      emit(const UpsertProductsLoadFailure(message: 'Products sheet missing!'));
      return;
    }

    final categories = await getCategoriesUseCase.execute(NoParams());

    categories.fold(
      (l) => emit(const UpsertProductsLoadFailure(
          message: 'Error loading the categories. Try again later.')),
      (categories) {
        try {
          int n = 1;
          for (int i = 1; i <= n; i++) {
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
              nullable: true,
            );
            num unitPriceCell = _getValueFromCell(
              sheet: productsSheet,
              expectedType: num,
              rowIndex: i,
              columnIndex: 3,
            );
            int? gtsCell = _getValueFromCell(
              sheet: productsSheet,
              expectedType: int,
              rowIndex: i,
              columnIndex: 4,
              nullable: true,
            );
            String unitOfMeasureCellStr = _getValueFromCell(
              sheet: productsSheet,
              expectedType: String,
              rowIndex: i,
              columnIndex: 5,
            );
            int? uomOrderIncrement = _getValueFromCell(
              sheet: productsSheet,
              expectedType: int,
              rowIndex: i,
              columnIndex: 6,
              nullable: true,
            );
            String? urlCell = _getValueFromCell(
              sheet: productsSheet,
              expectedType: String,
              rowIndex: i,
              columnIndex: 7,
              nullable: true,
            );
            String categoryCell = _getValueFromCell(
              sheet: productsSheet,
              expectedType: String,
              rowIndex: i,
              columnIndex: 8,
            );

            Unit unitOfMeasureCell;
            try {
              unitOfMeasureCell = Unit.fromString(unitOfMeasureCellStr);
            } catch (e) {
              throw TypeMismatchException(
                  "${productsSheet.sheetName} sheet - Expected a valid unit: row ${i + 1}, column 6");
            }

            int categoryId = _categoryIdIfExists(categories, categoryCell, i);

            Product product = Product(
              name: nameCell,
              sku: skuCell,
              description: descriptionCell,
              unitPrice: unitPriceCell.toDouble(),
              vat: gtsCell,
              unitOfMeasure: unitOfMeasureCell,
              uomOrderIncrement: uomOrderIncrement,
              url: urlCell,
              category: categoryId,
              supplier: 1,
            );

            products.add(product);

            if (productsSheet
                    .cell(CellIndex.indexByColumnRow(
                        columnIndex: 0, rowIndex: i + 1))
                    .value !=
                null) {
              n++;
            }
          }
        } on TypeMismatchException catch (e) {
          emit(UpsertProductsLoadFailure(message: e.toString()));
        }
      },
    );
  }

  dynamic _getValueFromCell({
    Sheet? sheet,
    required Type expectedType,
    required int rowIndex,
    required int columnIndex,
    bool nullable = false,
  }) {
    dynamic value;

    CellValue? cellValue = sheet!
        .cell(CellIndex.indexByColumnRow(
            columnIndex: columnIndex, rowIndex: rowIndex))
        .value;

    switch (cellValue) {
      case TextCellValue():
        value = cellValue.value;
        break;
      case IntCellValue():
        value = cellValue.value;
        break;
      case DoubleCellValue():
        value = cellValue.value;
        break;
      default:
        if (nullable == true) {
          return null;
        } else {
          value = null;
        }
    }

    if (expectedType != num && expectedType != value.runtimeType) {
      throw TypeMismatchException(
          "${sheet.sheetName} sheet - Expected type $expectedType but got ${value.runtimeType}: row ${rowIndex + 1}, column ${columnIndex + 1} A");
    } else if (expectedType == num && (value is! num)) {
      throw TypeMismatchException(
          "${sheet.sheetName} sheet - Expected type $expectedType but got ${value.runtimeType}: row ${rowIndex + 1}, column ${columnIndex + 1} B");
    }

    return value;
  }

  int _categoryIdIfExists(
      List<Category> categories, String categoryName, int rowIndex) {
    final category = categories.firstWhere(
      (cat) => cat.name == categoryName,
      orElse: () => throw TypeMismatchException(
          'sheet - Expected a valid category: row $rowIndex, column 8'),
    );

    return category.id!;
  }
}
