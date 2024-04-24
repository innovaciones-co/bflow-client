// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/core/utils/launch_url.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/presentation/bloc/items_bloc.dart';
import 'package:bflow_client/src/features/purchase_orders/presentation/widgets/materials_view_bar_widget.dart';
import 'package:bflow_client/src/features/purchase_orders/presentation/widgets/no_materials_widget.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/cross_scroll_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../aggregators/item_view.dart';
import 'write_material_widget.dart';

class JobMaterialsWidget extends StatelessWidget {
  JobMaterialsWidget({
    super.key,
  });

  int? jobId;

  final Map<int, TableColumnWidth> _columnWidths = {
    0: const FixedColumnWidth(100),
    1: const FixedColumnWidth(40),
    2: const FixedColumnWidth(140),
    3: const FixedColumnWidth(120),
    4: const FixedColumnWidth(120),
    5: const FixedColumnWidth(300),
    6: const FixedColumnWidth(60),
    7: const FixedColumnWidth(80),
    8: const FixedColumnWidth(110),
    9: const FixedColumnWidth(110),
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        if (state is! JobLoaded) {
          return const SizedBox.shrink();
        }

        final jobId = state.job.id!;

        return Expanded(
          child: BlocProvider<ItemsBloc>(
            create: (context) =>
                DependencyInjection.sl()..add(GetItemsEvent(jobId: jobId)),
            child: BlocBuilder<ItemsBloc, ItemsState>(
              builder: (context, state) {
                if (state is ItemsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ItemsFailed) {
                  return FailureWidget(failure: state.failure);
                }

                var items = (state as ItemsLoaded).items;
                var categories = (state).categories;
                var orders = (state).orders;
                var suppliers = (state).suppliers;

                if (items.isEmpty) {
                  return NoMaterialsWidget(
                    jobId: jobId,
                    itemsBloc: context.read(),
                  );
                }

                final double total = items
                    .map((e) => e.price)
                    .reduce((value, element) => value + element);

                final Map<int, List<ItemView>> itemsPerCategoryMap =
                    _itemsPerCategoryMap(items, categories, orders, suppliers);

                return Column(
                  children: [
                    const MaterialsViewBarWidget(),
                    const SizedBox(height: 15),
                    Expanded(
                      child: CrossScrollWidget(
                        child: Column(
                          children: [
                            _tableHeader(),
                            ...itemsPerCategoryMap.entries.map(
                              (e) => _categoryTable(context, e.value),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      color: AppColor.lightGrey,
                      child: Text(
                        'Total: ${total.toCurrency()}',
                        style: context.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Map<int, List<ItemView>> _itemsPerCategoryMap(
    List<Item> items,
    List<Category> categories,
    List<PurchaseOrder> orders,
    List<Contact> suppliers,
  ) {
    final groupedItems = <int, List<ItemView>>{};

    for (final item in items) {
      var itemView = ItemView(
        item: item,
        category: categories.firstWhereOrNull((c) => c.id == item.category),
        order: orders.firstWhereOrNull((o) => o.id == item.purchaseOrder),
        supplier: suppliers.firstWhereOrNull((s) => s.id == item.supplier),
      );
      groupedItems[item.category] = groupedItems[item.category] ?? [];
      groupedItems[item.category]!.add(itemView);
    }

    return groupedItems;
  }

  /* _itemsPerCategoryMap(List<Item> items) {
    Map<int, List<Item>> itemsPerCategoryMap = {};

    for (var item in items) {
      if (itemsPerCategoryMap.containsKey(item.category)) {
        itemsPerCategoryMap[item.category]!.add(item);
      } else {
        itemsPerCategoryMap[item.category] = [item];
      }
    }

    return itemsPerCategoryMap;
  } */

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
            _tableCell(const Text("Item ID")),
            _tableCell(const Text("Order Number")),
            _tableCell(const Text("Supplier")),
            _tableCell(const Text("Description")),
            _tableCell(const Text("Qty")),
            _tableCell(const Text("Measure")),
            _tableCell(const Text("Cost")),
            _tableCell(const Text("Total")),
          ],
        ),
      ],
    );
  }

  Widget _categoryTable(BuildContext context, List<ItemView> itemsView) {
    final double totalPerCategory = itemsView.map((i) => i.item.price).reduce(
          (a, b) => a + b,
        );

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
        _tableHeaderRow(itemsView.first.category?.id.toString() ?? "",
            itemsView.first.category?.name ?? "", totalPerCategory),
        for (int index = 0; index < itemsView.length; index += 1)
          _tableItemRow(itemsView[index]),
        TableRow(
          decoration: BoxDecoration(
            color: AppColor.white,
          ),
          children: [
            _tableCell(const Text("")),
            _tableCell(const Text("")),
            _tableCell(
              ActionButtonWidget(
                onPressed: () => _openWriteMaterialWidget(context),
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

  TableRow _tableHeaderRow(String code, String name, double total) {
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
          6,
          (index) => _tableCell(const Text("")),
        ),
        _tableCell(Text(
          total.toCurrency(),
          textAlign: TextAlign.end,
        )),
      ],
    );
  }

  TableRow _tableItemRow(ItemView itemView) {
    var item = itemView.item;

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
        _tableCell(Text(item.id.toString())),
        _tableCell(
          itemView.order != null
              ? ActionButtonWidget(
                  onPressed: () {
                    launchURL(
                        "http://localhost:8080/orders/${itemView.order?.id}");
                  },
                  type: ButtonType.textButton,
                  title: itemView.order?.number ?? "",
                )
              : const SizedBox.shrink(),
        ),

        //_tableCell(Text(itemView.order?.number ?? "")),
        _tableCell(Text(itemView.supplier?.name ?? "")),
        _tableCell(Text("${item.name}: ${item.description}")),
        _tableCell(
          // TODO: Implement edit and validation
          TextFormField(
            initialValue: item.units.toString(),
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
        _tableCell(Text(item.measure?.abbreviation ?? "")),
        _tableCell(Text(
          item.unitPrice.toCurrency(),
          textAlign: TextAlign.end,
        )),
        _tableCell(Text(
          item.price.toCurrency(),
          textAlign: TextAlign.end,
        )),
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

  _openWriteMaterialWidget(BuildContext context) {
    if (jobId == null) {
      return;
    }

    context.showLeftDialog('New Material',
        WriteMaterialWidget(itemsBloc: context.read(), jobId: jobId!));
  }
}
