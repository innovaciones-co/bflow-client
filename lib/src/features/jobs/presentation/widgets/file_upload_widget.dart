import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_category.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_tag.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/files/files_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/loading_widget.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:go_router/go_router.dart';

class FileUploadWidget extends StatefulWidget {
  final int? jobId;
  final int? taskId;
  final JobBloc jobBloc;

  const FileUploadWidget({
    super.key,
    this.jobId,
    this.taskId,
    required this.jobBloc,
  }) : assert(jobId != taskId);

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  bool isHighlighted = false;
  bool isUploading = false;
  DropzoneViewController? _controller;
  final List<File> _selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilesCubit>(
      create: (context) => FilesCubit(
        uploadFilesUseCase: DependencyInjection.sl(),
        deleteFilesUseCase: DependencyInjection.sl(),
        jobBloc: widget.jobBloc,
      ),
      child: Builder(builder: (context) {
        final FilesCubit filesCubit = context.read();

        return Column(
          children: [
            Container(
              height: 120,
              margin: const EdgeInsets.all(15),
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
            const SizedBox(
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
            ),
          ],
        );
      }),
    );
  }

  Wrap _showSelectedFiles() {
    return Wrap(
      children: _selectedFiles
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(right: 7, bottom: 5),
              child: Chip(
                label: Text(e.name),
                onDeleted: () {
                  setState(
                    () {
                      _selectedFiles.remove(e);
                    },
                  );
                },
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildChooseFilesArea(BuildContext context) {
    return BlocConsumer<FilesCubit, FilesState>(
      listener: (context, state) {
        if (state is FilesUploaded) {
          if (context.canPop()) {
            context.pop();
          }

          context.showAlert(
            message: "Files were uploaded!",
            type: AlertType.success,
          );
        }

        if (state is FilesError) {
          if (context.canPop()) {
            context.pop();
          }

          context.showAlert(
            message: state.failure.message ??
                "Couldn't upload files, please try again later.",
            type: AlertType.error,
          );
        }
      },
      builder: (context, state) {
        if (state is FilesLoading) {
          return const LoadingWidget();
        }

        return Container(
          padding: const EdgeInsets.all(15),
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
                        style:
                            context.bodyMedium?.copyWith(color: AppColor.grey),
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
      },
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
          task: widget.taskId,
          multipartFile: multipartFile,
        );
        _selectedFiles.add(file);
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

  _cancel(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }
}
