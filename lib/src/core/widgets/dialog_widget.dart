import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    this.title,
    required this.children,
  });

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        constraints: BoxConstraints(
          maxWidth:
              context.isDesktop ? context.width * 0.35 : context.width * 0.8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.white,
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title != null
                ? Text(
                    title!,
                    style: context.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )
                : const SizedBox(),
            title != null ? const SizedBox(height: 15) : const SizedBox(),
            ...children,
          ],
        ),
      ),
    );
  }
}
