// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_category.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';
import 'package:flutter/material.dart';

class DownloadFileWidget extends StatelessWidget {
  final File file;

  const DownloadFileWidget({
    super.key,
    required this.file,
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
            leading: Icon(
              _getIcon(file),
              size: 18,
            ),
            title: Text(file.name),
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

  IconData _getIcon(File file) {
    switch (file.category) {
      case FileCategory.photo:
        return Icons.image_outlined;
      case FileCategory.plan:
        return Icons.house_outlined;
      case FileCategory.document:
        return Icons.picture_as_pdf_outlined;
      default:
        return Icons.picture_as_pdf_outlined;
    }
  }
}
