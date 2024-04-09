import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';

import 'write_material_widget.dart';

class MaterialsViewBarWidget extends StatefulWidget {
  const MaterialsViewBarWidget({
    super.key,
  });

  @override
  State<MaterialsViewBarWidget> createState() => _MaterialsViewBarWidgetState();
}

class _MaterialsViewBarWidgetState extends State<MaterialsViewBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text("Search"),
            Container(
              width: 1,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: AppColor.grey,
            ),
          ],
        ),
        Row(
          children: [
            ActionButtonWidget(
              onPressed: () {},
              type: ButtonType.textButton,
              title: "Delete",
              icon: Icons.delete_outline,
              paddingHorizontal: 15,
              paddingVertical: 18,
            ),
            const SizedBox(width: 12),
            ActionButtonWidget(
              onPressed: () => context.showLeftDialog(
                  'New Material', const WriteMaterialWidget()),
              type: ButtonType.elevatedButton,
              title: "Add Materials",
              icon: Icons.add,
              backgroundColor: AppColor.lightBlue,
            ),
            const SizedBox(width: 12),
            ActionButtonWidget(
              onPressed: null,
              type: ButtonType.elevatedButton,
              title: "Create purchase order",
              icon: Icons.monetization_on_outlined,
              backgroundColor: AppColor.blue,
              foregroundColor: AppColor.white,
            ),
          ],
        ),
      ],
    );
  }
}
