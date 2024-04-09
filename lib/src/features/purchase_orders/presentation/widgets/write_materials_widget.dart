import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:flutter/material.dart';

const List<String> list = [
  'One',
  'Two',
  'Three',
  'Four',
]; // TODO: Delete when DropDown completed

class WriteMaterialsWidget extends StatelessWidget {
  const WriteMaterialsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownWidget<String>(
          label: "Category",
          items: list,
          getLabel: (s) => s,
          onChanged: null,
          initialValue: list.first,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ActionButtonWidget(
              onPressed: () {
                Navigator.of(context).pop();
              },
              type: ButtonType.textButton,
              title: "Cancel",
              paddingHorizontal: 15,
              paddingVertical: 18,
            ),
            const SizedBox(width: 12),
            ActionButtonWidget(
              onPressed: () {},
              type: ButtonType.elevatedButton,
              title: "Import Materials",
              backgroundColor: AppColor.blue,
              foregroundColor: AppColor.white,
            ),
          ],
        )
      ],
    );
  }
}
