// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/file_download.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_category.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/files/files_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileDownloadWidget extends StatefulWidget {
  final File file;

  const FileDownloadWidget({
    super.key,
    required this.file,
  });

  @override
  State<FileDownloadWidget> createState() => _FileDownloadWidgetState();
}

class _FileDownloadWidgetState extends State<FileDownloadWidget> {
  bool _isDownloaded = false;
  bool _isDownloading = false;

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

      return BlocSelector<FilesCubit, FilesState, bool>(
        selector: (state) {
          if (state is FilesSelected) {
            return (state).selectedFiles.contains(widget.file);
          }
          return false;
        },
        builder: (context, isSelected) {
          return SizedBox(
            width: colWidth,
            child: Card(
              color: isSelected ? AppColor.lightOrange : AppColor.lightBlue,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: InkWell(
                onTap: () =>
                    context.read<FilesCubit>().toggleSelectedFile(widget.file),
                child: ListTile(
                  horizontalTitleGap: 8,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  leading: Icon(
                    _getIcon(widget.file),
                    size: 18,
                  ),
                  title: Tooltip(
                    message: widget.file.name,
                    child: Text(
                      widget.file.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      setState(() {
                        _isDownloading = true;
                      });
                      bool downloaded = await FileDownload.downloadFile(
                          widget.file.temporaryUrl, widget.file.name);
                      setState(() {
                        _isDownloaded = downloaded;
                        _isDownloading = false;
                      });
                    },
                    icon: _isDownloading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            !_isDownloaded
                                ? Icons.download
                                : Icons.done_outlined,
                            color: !_isDownloaded
                                ? AppColor.black
                                : AppColor.green,
                            size: 22,
                          ),
                  ),
                ),
              ),
            ),
          );
        },
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
