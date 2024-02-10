import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/date_picker_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:flutter/material.dart';

const List<String> list = ['One', 'Two', 'Three', 'Four']; // Dropdown list

class CreateActivityWidget extends StatelessWidget {
  CreateActivityWidget({super.key});

  final TextEditingController starDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownWidget<String>(
          label: "Stage",
          items: list,
          getLabel: (s) => s,
          onChanged: null,
          initialValue: list.first,
        ),
        const SizedBox(height: 20),
        DropdownWidget<String>(
          label: "Parent Task",
          items: list,
          getLabel: (a) => a,
          onChanged: null,
          initialValue: list.first,
        ),
        const SizedBox(height: 20),
        const InputWidget(label: "Name Task"),
        const SizedBox(height: 20),
        DropdownWidget<String>(
          label: "Supplier",
          items: list,
          getLabel: (r) => r,
          onChanged: null,
          initialValue: list.first,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: DropdownWidget<TaskStatus>(
                label: "Stage",
                items: TaskStatus.values,
                getLabel: (i) => i.name,
                onChanged: null,
                initialValue: TaskStatus.created,
              ),
            ),
            const SizedBox(width: 15),
            const Expanded(
              child: InputWidget(
                label: "Progress",
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Row(
          children: [
            Expanded(
              child: DatePickerWidget(
                label: "Booking Date",
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: DatePickerWidget(
                label: "End Date",
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const InputWidget(label: "Comments"),
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
              title: "Send email",
              backgroundColor: AppColor.lightBlue,
            ),
            const SizedBox(width: 12),
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
