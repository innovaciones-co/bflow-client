import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/job_item_widget.dart';
import 'package:flutter/material.dart';

class JobPage extends StatelessWidget {
  const JobPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainerWidget(
        title: "Call forward",
        child: Column(
          children: [
            const JobItemWidget(),
            Row(
              children: [
                TextButtonWidget(
                    title: "View jobs documents", icon: Icons.all_inbox_sharp),
                TextButtonWidget(
                    title: "View all task", icon: Icons.task_outlined),
                const Switch(
                  // TODO: make it work
                  value: false,
                  activeColor: Colors.red,
                  onChanged: null,
                ),
                const Text("View calendar")
              ],
            ),
            Row(
              children: [
                const Text("Search"),
                const Text("Filter"),
                const Text("Water Meter call up"),
                TextButtonWidget(title: "Delete", icon: Icons.delete_outline),
                TextButtonWidget(title: "Send task", icon: Icons.mail_outline, backgroundColor: Colors.blue.shade50, foregroundColor: Colors.blue,),
                const SizedBox(width: 12),
                TextButtonWidget(title: "New Activity", icon: Icons.add, backgroundColor: Colors.blue, foregroundColor: Colors.white,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  final String title;
  IconData? icon;
  Color? backgroundColor;
  Color? foregroundColor;

  TextButtonWidget({
    super.key,
    required this.title,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: backgroundColor != null ? const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 18, horizontal: 15)) : const MaterialStatePropertyAll(EdgeInsets.all(0)),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      ),
      child: Row(
        children: [
          icon != null ? Icon(icon, size: 18) : const SizedBox(),
          icon != null ? const SizedBox(width: 6) : const SizedBox(),
          Text(title),
        ],
      ),
    );
  }
}
