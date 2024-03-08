import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/no_materials_widget.dart';
import 'package:flutter/material.dart';

final Map<int, TableColumnWidth> columnWidths = {
  0: FixedColumnWidth(100),
  1: FixedColumnWidth(40),
  2: FixedColumnWidth(110),
  3: FixedColumnWidth(110),
  4: FixedColumnWidth(170),
  5: FixedColumnWidth(250),
  6: FixedColumnWidth(100),
  7: FixedColumnWidth(100),
  8: FixedColumnWidth(100),
  9: FixedColumnWidth(100),
};

class JobMaterialsWidget extends StatelessWidget {
  const JobMaterialsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Table(
            columnWidths: columnWidths,
            border: TableBorder(
              right: BorderSide(width: 1.0, color: AppColor.lightGrey),
              bottom: BorderSide(width: 1.0, color: AppColor.darkGrey),
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
                    value: true,
                    onChanged: null,
                    side: BorderSide(color: AppColor.darkGrey, width: 2),
                  )),
                  _tableCell(const Text("Item ID")),
                  _tableCell(const Text("Order ID")),
                  _tableCell(const Text("Supplier")),
                  _tableCell(const Text("Description")),
                  _tableCell(const Text("Qty")),
                  _tableCell(const Text("Measure")),
                  _tableCell(const Text("Rate")),
                  _tableCell(const Text("Total")),
                ],
              ),
            ],
          ),
          const NoMaterialsWidget(),
        ],
      ),
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
}
