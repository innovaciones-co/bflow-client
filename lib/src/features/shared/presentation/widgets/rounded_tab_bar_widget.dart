import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:flutter/material.dart';

class RoundedTabBarWidget extends StatefulWidget {
  final List<RoundedTabBarItem> items;
  final Function(int index) onPressed;
  final int defaultIndex;

  const RoundedTabBarWidget({
    super.key,
    required this.items,
    this.defaultIndex = 0,
    required this.onPressed,
  });

  @override
  State<RoundedTabBarWidget> createState() => _RoundedTabBarWidgetState();
}

class _RoundedTabBarWidgetState extends State<RoundedTabBarWidget> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.defaultIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.items
          .map((item) => _collapsibleButton(
                isExpanded: _selectedIndex == widget.items.indexOf(item),
                onPressed: () => selectIndex(widget.items.indexOf(item)),
                text: item.label,
                icon: item.icon,
              ))
          .toList(),
    );
  }

  Widget _collapsibleButton({
    required bool isExpanded,
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    bool first = false,
    bool last = false,
  }) {
    Color foregroundColor = isExpanded ? AppColor.lightBlue : AppColor.darkGrey;
    Color backgroundColor = isExpanded ? AppColor.blue : AppColor.grey;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? 180 : 55,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 5)),
          overlayColor:
              MaterialStateProperty.all(foregroundColor.withOpacity(0.05)),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(foregroundColor),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(first ? 15 : 0),
                right: Radius.circular(last ? 15 : 0)),
          )),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            SizedBox(width: isExpanded ? 6 : 0),
            Text(isExpanded ? text : ''), // TODO: Delay 300ms
          ],
        ),
      ),
    );
  }

  void selectIndex(int index) {
    widget.onPressed(index);
    setState(() {
      _selectedIndex = index;
    });
  }
}

class RoundedTabBarItem {
  final IconData icon;
  final String label;

  RoundedTabBarItem({
    required this.icon,
    required this.label,
  });
}
