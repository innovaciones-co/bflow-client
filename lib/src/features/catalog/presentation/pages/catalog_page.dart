import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/features/catalog/presentation/widgets/catalog_view_bar_widget.dart';
import 'package:bflow_client/src/features/catalog/presentation/widgets/write_product_widget.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/cross_scroll_widget.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatelessWidget {
  final int supplierId;

  CatalogPage({
    super.key,
    required this.supplierId,
  });

  final Map<int, TableColumnWidth> _columnWidths = {
    0: const FixedColumnWidth(100),
    1: const FixedColumnWidth(40),
    2: const FixedColumnWidth(140),
    3: const FixedColumnWidth(250),
    4: const FixedColumnWidth(350),
    5: const FixedColumnWidth(80),
    6: const FixedColumnWidth(60),
    7: const FixedColumnWidth(95),
    8: const FixedColumnWidth(110),
    9: const FixedColumnWidth(180),
  };

  @override
  Widget build(BuildContext context) {
    return PageContainerWidget(
      title: 'Supplier catalog',
      child: Column(
        children: [
          const CatalogViewBarWidget(),
          const SizedBox(height: 15),
          Expanded(
            child: CrossScrollWidget(
              child: Column(
                children: [
                  _tableHeader(),
                  _categoryTable(context),
                  _categoryTable(context),
                  _categoryTable(context),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Table _tableHeader() {
    return Table(
      columnWidths: _columnWidths,
      border: TableBorder(
        right: BorderSide(width: 1.0, color: AppColor.lightGrey),
        bottom: BorderSide(width: 0.5, color: AppColor.darkGrey),
        left: BorderSide(width: 1.0, color: AppColor.lightGrey),
        verticalInside: BorderSide(width: 1.0, color: AppColor.lightGrey),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: AppColor.grey,
          ),
          children: [
            _tableCell(const Text("Trade code")),
            _tableCell(Checkbox(
              value: false,
              onChanged: null,
              side: BorderSide(color: AppColor.darkGrey, width: 2),
            )),
            _tableCell(const Text("Sku")),
            _tableCell(const Text("Product name")),
            _tableCell(const Text("Description")),
            _tableCell(const Text("Measure")),
            _tableCell(const Text("Rate")),
            _tableCell(const Text("Increment")),
            _tableCell(const Text("Date Created")),
            _tableCell(const Text("Actions")),
          ],
        ),
      ],
    );
  }

  _tableCell(Widget widget, {double? paddingRight, double? paddingLeft}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.only(
            right: paddingRight ?? 10,
            left: paddingLeft ?? 10,
            top: 5,
            bottom: 5),
        child: widget,
      ),
    );
  }

  Widget _categoryTable(BuildContext context) {
    return Table(
      columnWidths: _columnWidths,
      border: TableBorder(
        top: BorderSide(width: 0.5, color: AppColor.lightPurple),
        right: BorderSide(width: 1.0, color: AppColor.lightPurple),
        bottom: BorderSide(width: 0.5, color: AppColor.lightPurple),
        left: BorderSide(width: 1.0, color: AppColor.lightPurple),
        horizontalInside: BorderSide(width: 1.0, color: AppColor.lightPurple),
        verticalInside: BorderSide(width: 1.0, color: AppColor.lightPurple),
      ),
      children: [
        _tableCategoryRow(
          "123",
          "Category",
        ),
        _tableItemRow(context),
        _tableItemRow(context),
        _tableItemRow(context),
      ],
    );
  }

  TableRow _tableCategoryRow(String code, String name) {
    return TableRow(
      decoration: BoxDecoration(
        color: AppColor.lightPurple,
      ),
      children: [
        _tableCell(Text(code)),
        _tableCell(Checkbox(
          value: false,
          onChanged: null,
          side: BorderSide(color: AppColor.darkGrey, width: 2),
        )),
        _tableCell(Text(name)),
        ...List.generate(
          7,
          (index) => _tableCell(const Text("")),
        ),
      ],
    );
  }

  TableRow _tableItemRow(BuildContext context) {
    return TableRow(
      decoration: BoxDecoration(
        color: AppColor.white,
      ),
      children: [
        _tableCell(const Text("")),
        _tableCell(
          Checkbox(
            value: false,
            onChanged: null,
            side: BorderSide(color: AppColor.darkGrey, width: 2),
          ),
        ),
        _tableCell(const Text('Sku')),
        _tableCell(const Text('Product name')),
        _tableCell(const Text('Description')),
        _tableCell(const Text("Measure")),
        _tableCell(const Text("Rate")),
        _tableCell(const Text('Increment')),
        _tableCell(const Text('Data created')),
        _tableCell(
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => context.showLeftDialog(
                    "Edit Product",
                    WriteProductWidget(),
                  ), // TODO: Implement edit
                  color: AppColor.blue,
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: () {}, // TODO: Implement delete
                  color: AppColor.blue,
                  icon: const Icon(
                    Icons.delete_outline_outlined,
                    size: 20,
                  ),
                  tooltip: 'Delete',
                ),
                IconButton(
                  onPressed: () {}, // TODO: Implement external link
                  color: AppColor.blue,
                  icon: const Icon(
                    Icons.link_outlined,
                    size: 20,
                  ),
                  tooltip: 'Open Link',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
