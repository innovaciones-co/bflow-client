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
                first: widget.items.first == item,
                last: widget.items.last == item,
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
    Color foregroundColor = isExpanded ? AppColor.blue : AppColor.darkGrey;
    Color backgroundColor =
        isExpanded ? AppColor.blue.withOpacity(0.1) : AppColor.lightGrey;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? 180 : 60,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding:
              const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 5)),
          overlayColor:
              WidgetStateProperty.all(foregroundColor.withOpacity(0.05)),
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          foregroundColor: WidgetStateProperty.all(foregroundColor),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
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
            Flexible(
              child: Text(
                isExpanded ? text : '',
                overflow: TextOverflow.fade,
                maxLines: 1,
              ),
            ),
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
