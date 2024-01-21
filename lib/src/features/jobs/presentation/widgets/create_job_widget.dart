import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class CreateJobWidget extends StatelessWidget {
  const CreateJobWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InputWidget(title: "Job Number"),
        const InputWidget(title: "Address"),
        const InputWidget(title: "Project supervisor"),
        const InputWidget(title: "Owner name"),
        const InputWidget(title: "Template"),
        const Row(
          children: [
            Expanded(child: InputWidget(title: "Start Date")),
            Expanded(child: InputWidget(title: "Start Date")),
          ],
        ),
        TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            hintText: "",
          ),
        ),
        const DropdownMenuExample(), // TODO: Customize
      ],
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      expandedInsets: EdgeInsets.zero,
      initialSelection: list.first,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
