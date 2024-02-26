import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:flutter/material.dart';

class NoTasksWidget extends StatelessWidget {
  const NoTasksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/no_data_found.png',
          ),
          const SizedBox(height: 15),
          Text(
            "No activities yet",
            style: context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text("Add a new activity"),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionButtonWidget(
                  onPressed: () {
                    _createActivityFromTemplate(context);
                  },
                  type: ButtonType.textButton,
                  title: "Create from template"),
            ],
          )
        ],
      ),
    );
  }
}

_createActivityFromTemplate(BuildContext context) {
  List<String> testList = ['1', '2', '3'];
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColor.white,
            ),
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add new activities",
                  style:
                      context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                DropdownWidget<String>(
                  label:
                      "Choose the template you want to use to create the activities:",
                  items: testList, // TODO: Replace with templates list
                  getLabel: (testList) => testList,
                  onChanged: null,
                  initialValue: testList[1],
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
                      title: "Create",
                      backgroundColor: AppColor.blue,
                      foregroundColor: AppColor.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
