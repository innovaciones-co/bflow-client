import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class DownloadFileWidget extends StatelessWidget {
  const DownloadFileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var colNumber = 1;
      if (!context.isMobile) {
        colNumber = context.isSmallTablet
            ? 2
            : context.isTablet
                ? 3
                : 4;
      }
      var colWidth = (constraints.maxWidth - (colNumber - 1) * 10) / colNumber;

      return SizedBox(
        width: colWidth,
        child: Card(
          color: AppColor.lightBlue,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: ListTile(
            horizontalTitleGap: 8,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            leading: const Icon(
              Icons.photo,
              size: 18,
            ),
            title: const Text('Plans'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.download,
                size: 22,
              ),
            ),
          ),
        ),
      );
    });
  }
}
