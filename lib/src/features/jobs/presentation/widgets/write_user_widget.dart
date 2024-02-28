import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:flutter/material.dart';

const List<String> list = [
  'One',
  'Two',
  'Three',
  'Four',
]; // TODO: Delete when DropDown completed

class WriteUserWidget extends StatelessWidget {
  const WriteUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Expanded(child: InputWidget(label: "Name")),
            SizedBox(width: 15),
            Expanded(child: InputWidget(label: "Last Name")),
          ],
        ),
        const SizedBox(height: 20),
        const InputWidget(label: "Email"),
        const SizedBox(height: 20),
        DropdownWidget<String>(
          label: "Role",
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
              title: "Create User",
              backgroundColor: AppColor.blue,
              foregroundColor: AppColor.white,
            ),
          ],
        )
      ],
    );
  }
}
