import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/date_picker_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:flutter/material.dart';

const List<String> list = ['One', 'Two', 'Three', 'Four']; // Dropdown list

class CreateJobWidget extends StatelessWidget {
  CreateJobWidget({super.key});

  final TextEditingController starDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InputWidget(label: "Job Number"),
        const SizedBox(height: 20),
        const InputWidget(label: "Address"),
        const SizedBox(height: 20),
        const DropdownWidget(label: "Project supervisor"),
        const SizedBox(height: 20),
        const DropdownWidget(label: "Owner name"),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: DatePickerWidget(
                dateController: starDateController,
                label: "Start Date",
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: DatePickerWidget(
                dateController: endDateController,
                label: "End Date",
              ),
            ),
          ],
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
            ),
            const SizedBox(width: 20),
            ActionButtonWidget(
              onPressed: () {},
              type: ButtonType.elevatedButton,
              title: "Save",
              backgroundColor: AppColor.blue,
              foregroundColor: AppColor.white,
            ),
          ],
        )
      ],
    );
  }
}
