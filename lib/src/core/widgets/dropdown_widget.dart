import 'package:bflow_client/src/features/jobs/presentation/widgets/create_job_widget.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final String? lable; // TODO: implement optional label

  const DropdownWidget({super.key, this.lable});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //label != null ? Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text(label),) : SizedBox.shrink();
        //label != null ? SizedBox(height: 5) : SizedBox.shrink();
        DropdownMenu(
          menuStyle: MenuStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            surfaceTintColor: MaterialStateProperty.all(Colors.grey),
          ),
          expandedInsets: EdgeInsets.zero,
          trailingIcon: const Icon(Icons.keyboard_arrow_down_outlined),
          selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_outlined),
          initialSelection: "",
          onSelected: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          dropdownMenuEntries: list.map((String value) {
            return DropdownMenuEntry(value: value, label: value);
          }).toList(),
        ),
      ],
    );
  }
}
