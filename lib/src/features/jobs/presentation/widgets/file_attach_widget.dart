import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_category.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_tag.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/files/files_cubit.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/loading_widget.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class FileAttachWidget extends StatefulWidget {
  final int? jobId;
  final int? taskId;
  final List<File> initialFiles;
  final Function(List<File>)? onChange;

  const FileAttachWidget({
    super.key,
    this.jobId,
    this.taskId,
    this.initialFiles = const [],
    this.onChange,
  }) : assert(jobId != taskId);

  @override
  State<FileAttachWidget> createState() => _FileAttachWidgetState();
}

class _FileAttachWidgetState extends State<FileAttachWidget> {
  bool isHighlighted = false;
  bool isUploading = false;
  DropzoneViewController? _controller;
  late final List<File> _selectedFiles;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        _selectedFiles = List.of(widget.initialFiles);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: isUploading
              ? const LoadingWidget()
              : Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: DropzoneView(
                        onCreated: _onCreated,
                        onDrop: _addFile,
                        onHover: () => setState(() {
                          isHighlighted = true;
                        }),
                        onLeave: () => setState(() {
                          isHighlighted = false;
                        }),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: _buildChooseFilesArea(context),
                    ),
                  ],
                ),
        ),
        const SizedBox(
          height: 5,
        ),
        _showSelectedFiles(),
        /* const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButtonWidget(
                onPressed: () => _cancel(context),
                type: ButtonType.textButton,
                title: "Cancel",
                foregroundColor: AppColor.blue,
              ),
              const SizedBox(
                width: 15,
              ),
              ActionButtonWidget(
                onPressed: () => _save(filesCubit),
                type: ButtonType.elevatedButton,
                title: "Upload",
                foregroundColor: AppColor.white,
                backgroundColor: AppColor.blue,
              ),
            ],
          ), */
      ],
    );
  }

  Wrap _showSelectedFiles() {
    return Wrap(
      children: _selectedFiles
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(right: 7, bottom: 5),
              child: Chip(label: Text(e.name), onDeleted: () => _removeFile(e)),
            ),
          )
          .toList(),
    );
  }

  Widget _buildChooseFilesArea(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isHighlighted ? AppColor.lightBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DottedBorder(
        dashPattern: const [10, 2],
        color: AppColor.grey,
        radius: const Radius.circular(10),
        strokeWidth: 1,
        padding: const EdgeInsets.all(15),
        borderType: BorderType.RRect,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Wrap(
                children: [
                  Icon(
                    Icons.upload_file_outlined,
                    color: AppColor.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Select or update your files here",
                    style: context.bodyMedium?.copyWith(color: AppColor.grey),
                  ),
                ],
              ),
              TextButton(
                onPressed: _pickFile,
                child: Text(
                  "Choose files",
                  style: context.bodyMedium?.copyWith(color: AppColor.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _pickFile() async {
    final events = await _controller?.pickFiles();
    if (events?.isEmpty ?? false) return;

    for (var element in events!) {
      _addFile(element);
    }
  }

  void _addFile(value) async {
    setState(() {
      isUploading = true;
    });
    final fileName = await _controller?.getFilename(value);
    final url = await _controller?.createFileUrl(value);
    final multipartFile = await createMultipartFile(value);

    setState(() {
      if (fileName != null && url != null) {
        var file = File(
          name: fileName,
          temporaryUrl: url,
          category: FileCategory.fromExtension(fileName.split(".").last),
          tag: FileTag.fromFilename(fileName),
          job: widget.jobId,
          multipartFile: multipartFile,
        );
        _selectedFiles.add(file);
        if (widget.onChange != null) {
          widget.onChange!(_selectedFiles);
        }
      }
      isHighlighted = false;
      isUploading = false;
    });

    debugPrint(fileName);
  }

  Future<MultipartFile?> createMultipartFile(dynamic value) async {
    final fileData = await _controller?.getFileData(value);
    final fileName = await _controller?.getFilename(value);

    if (fileData != null) {
      MultipartFile multipartFile = MultipartFile.fromBytes(
        fileData,
        filename: fileName,
      );
      return multipartFile;
    }
    return null;
  }

  void _onCreated(DropzoneViewController controller) {
    _controller = controller;
  }

  _save(FilesCubit filesCubit) {
    filesCubit.uploadFiles(_selectedFiles);
  }

  _removeFile(File file) {
    setState(
      () {
        _selectedFiles.remove(file);

        if (widget.onChange != null) {
          widget.onChange!(_selectedFiles);
        }
      },
    );
  }
}
