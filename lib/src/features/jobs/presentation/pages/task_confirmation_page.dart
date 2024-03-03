import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskConfirmationPage extends StatelessWidget {
  const TaskConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final query = state.queryParams['id'];
    //GoRouterState.of(context).pathParameters['id']!
    String action = "completed";
    Map<String, String> data = {};
    Color lineColor = Colors.transparent;
    String title = "";
    String subTitle = "";
    switch (action) {
      case "completed":
        data = {
          'Action': 'completed',
          'Job number': 'SH2235',
          'Addresss': '#94 Pola St Dianella',
          'Order': '12345',
          'Booking Date': '01 Jan 2023',
          'End Date': '01 Jan 2023',
        };
        lineColor = AppColor.green;
        title = "The task has been confimed";
        subTitle = "Thank you!";
        break;
      case "date":
        data = {
          'Action': 'date',
          'Job number': 'SH2235',
          'Addresss': '#94 Pola St Dianella',
          'Order': '12345',
          'Booking Date': '01 Jan 2023',
          'Coments':
              'This job is ready to go please deliver any time before 11th, bcndcndosnvcodwv dwv dwjkvnalknj dksnv odnaiov ndfoav iofanov ',
          'Supplier': 'JHL cartage',
          'Project supervisor': 'Alberto Federico',
          'End Date': '01 Jan 2023',
        };
        lineColor = Colors.transparent;
        title = "Propose a new date";
        subTitle = "Select the date and send it for confirmation";
        break;
      case "reject":
        data = {
          'Action': 'reject',
          'Job number': 'SH2235',
          'Addresss': '#94 Pola St Dianella',
          'Order': '12345',
          'Booking Date': '01 Jan 2023',
        };
        lineColor = AppColor.red;
        title = "The task has been rejected";
        subTitle = "Contact the supervisor";
        break;
    }

    return Container(
      color: AppColor.darkGrey,
      width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
            decoration: BoxDecoration(
              color: AppColor.black,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.asset(
              'assets/img/sh_logo_and_text.png',
              height: 25,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(5),
              border: Border(
                left: BorderSide(
                  color: lineColor,
                  width: 5,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(subTitle),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(140),
                  },
                  children: [
                    ...data.entries.map((entry) {
                      return _tableRow(entry.key, entry.value, context);
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButtonWidget(
                      onPressed: () {},
                      type: ButtonType.elevatedButton,
                      title: action != "date" ? "Close" : "Cancel",
                      backgroundColor:
                          action != "date" ? AppColor.blue : AppColor.lightBlue,
                      foregroundColor:
                          action != "date" ? AppColor.white : AppColor.blue,
                    ),
                    action != "date"
                        ? const SizedBox.shrink()
                        : Wrap(
                            children: [
                              const SizedBox(width: 15),
                              ActionButtonWidget(
                                onPressed: () {},
                                type: ButtonType.elevatedButton,
                                title: "Propose date",
                                backgroundColor: AppColor.blue,
                                foregroundColor: AppColor.white,
                              )
                            ],
                          ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TableRow _tableRow(String title, String subTitle, BuildContext context) {
    return TableRow(
      children: [
        _tableCell(Text(
          title,
          style: context.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        )),
        _tableCell(
          Text(subTitle),
        ),
      ],
    );
  }

  Widget _tableCell(Widget widget,
      {double? paddingRight,
      double? paddingLeft,
      double? paddingTop,
      double? paddingBottom}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.top,
      child: Padding(
        padding: EdgeInsets.only(
            right: paddingRight ?? 10,
            left: paddingLeft ?? 0,
            top: paddingTop ?? 10,
            bottom: paddingBottom ?? 10),
        child: widget,
      ),
    );
  }
}
