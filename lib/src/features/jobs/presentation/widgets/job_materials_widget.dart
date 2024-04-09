import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/materials_view_bar_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/write_material_widget.dart';
import 'package:flutter/material.dart';

final Map<int, TableColumnWidth> columnWidths = {
  0: const FixedColumnWidth(100),
  1: const FixedColumnWidth(40),
  2: const FixedColumnWidth(140),
  3: const FixedColumnWidth(120),
  4: const FixedColumnWidth(170),
  5: const FixedColumnWidth(500),
  6: const FixedColumnWidth(60),
  7: const FixedColumnWidth(80),
  8: const FixedColumnWidth(110),
  9: const FixedColumnWidth(110),
};

class JobMaterialsWidget extends StatelessWidget {
  const JobMaterialsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MaterialsViewBarWidget(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Table(
                columnWidths: columnWidths,
                border: TableBorder(
                  right: BorderSide(width: 1.0, color: AppColor.lightGrey),
                  bottom: BorderSide(width: 0.5, color: AppColor.darkGrey),
                  left: BorderSide(width: 1.0, color: AppColor.lightGrey),
                  verticalInside:
                      BorderSide(width: 1.0, color: AppColor.lightGrey),
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
                      _tableCell(const Text("Item ID")),
                      _tableCell(const Text("Order Number")),
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
              //const NoMaterialsWidget(),
              _categoryTable(context),
              _categoryTable(context),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          color: AppColor.lightGrey,
          child: Text(
            'Total: \$78400,00',
            style: context.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }

  Table _categoryTable(BuildContext context) {
    return Table(
      columnWidths: columnWidths,
      border: TableBorder(
        top: BorderSide(width: 0.5, color: AppColor.lightPurple),
        right: BorderSide(width: 1.0, color: AppColor.lightPurple),
        bottom: BorderSide(width: 0.5, color: AppColor.lightPurple),
        left: BorderSide(width: 1.0, color: AppColor.lightPurple),
        horizontalInside: BorderSide(width: 1.0, color: AppColor.lightPurple),
        verticalInside: BorderSide(width: 1.0, color: AppColor.lightPurple),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: AppColor.lightPurple,
          ),
          children: [
            _tableCell(const Text("1200")),
            _tableCell(Checkbox(
              value: false,
              onChanged: null,
              side: BorderSide(color: AppColor.darkGrey, width: 2),
            )),
            _tableCell(const Text("Reforimecent")),
            _tableCell(const Text("")),
            _tableCell(const Text("")),
            _tableCell(const Text("")),
            _tableCell(const Text("")),
            _tableCell(const Text("")),
            _tableCell(const Text("")),
            _tableCell(const Text("\$88400,00")),
          ],
        ),
        _tableRow(),
        _tableRow(),
        _tableRow(),
        _tableRow(),
        TableRow(
          decoration: BoxDecoration(
            color: AppColor.white,
          ),
          children: [
            _tableCell(const Text("")),
            _tableCell(const Text("")),
            _tableCell(
              ActionButtonWidget(
                onPressed: () => context.showLeftDialog(
                    'New Material', const WriteMaterialWidget()),
                type: ButtonType.textButton,
                title: "Add Material",
                icon: Icons.add,
              ),
            ),
            _tableCell(const Text("")),
            _tableCell(const Text("")),
            _tableCell(const Text("")),
            _tableCell(const Text("")),
            _tableCell(const Text("")),
            _tableCell(const Text("")),
            _tableCell(const Text("")),
          ],
        ),
      ],
    );
  }

  TableRow _tableRow() {
    return TableRow(
      decoration: BoxDecoration(
        color: AppColor.white,
      ),
      children: [
        _tableCell(const Text("")),
        _tableCell(Checkbox(
          value: false,
          onChanged: null,
          side: BorderSide(color: AppColor.darkGrey, width: 2),
        )),
        _tableCell(const Text("1200")),
        _tableCell(const Text("#020230")),
        _tableCell(const Text("Slab mesh AUS")),
        _tableCell(const Text("Slab mesh square - RM 62 (6x24m)")),
        _tableCell(
          TextFormField(
            initialValue: '123',
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              //errorBorder: InputBorder.none,
              //hintText: hintText,
            ),
          ),
          paddingLeft: 1,
          paddingRight: 1,
        ),
        _tableCell(const Text("m2")),
        _tableCell(const Text("\$68,00")),
        _tableCell(const Text("\$884,00")),
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
}
