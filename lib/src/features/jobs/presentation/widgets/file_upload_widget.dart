import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:go_router/go_router.dart';

class FileUploadWidget extends StatefulWidget {
  const FileUploadWidget({super.key});

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  DropzoneViewController? _controller;
  final List<String> _selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          margin: const EdgeInsets.all(15),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: DropzoneView(
                  onCreated: _onCreated,
                  onDrop: _onDrop,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: DottedBorder(
                  dashPattern: const [10, 2],
                  color: AppColor.grey,
                  radius: const Radius.circular(10),
                  strokeWidth: 1,
                  padding: const EdgeInsets.all(15),
                  strokeCap: StrokeCap.round,
                  child: Center(
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Icon(Icons.upload_file_outlined,
                                color: AppColor.grey),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Select or update your files here",
                              style: context.bodyMedium
                                  ?.copyWith(color: AppColor.grey),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () async {
                            final events = await _controller?.pickFiles();
                            if (events?.isEmpty ?? false) return;

                            for (var element in events!) {
                              _onDrop(element);
                            }
                          },
                          child: Text(
                            "Choose files",
                            style: context.bodyMedium
                                ?.copyWith(color: AppColor.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Wrap(
          children: _selectedFiles
              .map(
                (e) => Container(
                  margin: const EdgeInsets.only(right: 7, bottom: 5),
                  child: Chip(
                    label: Text(e),
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
        ),
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
              onPressed: _save,
              type: ButtonType.elevatedButton,
              title: "Upload",
              foregroundColor: AppColor.white,
              backgroundColor: AppColor.blue,
            ),
          ],
        ),
      ],
    );
  }

  void _onDrop(value) async {
    final fileName = await _controller?.getFilename(value);

    setState(() {
      if (fileName != null) {
        _selectedFiles.add(fileName);
      }
    });

    debugPrint(fileName);
  }

  void _onCreated(DropzoneViewController controller) {
    _controller = controller;
  }

  _save() {}

  _cancel(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }
}
