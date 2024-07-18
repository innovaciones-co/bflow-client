import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';

class ConfirmationWidget extends StatelessWidget {
  const ConfirmationWidget({
    super.key,
    this.title,
    this.onCancel,
    this.onConfirm,
    this.description,
    this.cancelText = "Cancel",
    this.confirmText = "Accept",
  });

  final String? title;
  final String? description;
  final String cancelText;
  final String confirmText;
  final dynamic Function()? onCancel;
  final dynamic Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        constraints: BoxConstraints(
          maxWidth:
              context.isDesktop ? context.width * 0.3 : context.width * 0.8,
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
            description != null
                ? Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Text(description!),
                  )
                : const SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ActionButtonWidget(
                  onPressed: onCancel ??
                      () {
                        Navigator.of(context).pop();
                      },
                  type: ButtonType.textButton,
                  title: cancelText,
                  paddingHorizontal: 15,
                  paddingVertical: 18,
                ),
                const SizedBox(width: 12),
                ActionButtonWidget(
                  onPressed: onConfirm,
                  type: ButtonType.elevatedButton,
                  title: confirmText,
                  backgroundColor: AppColor.blue,
                  foregroundColor: AppColor.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
