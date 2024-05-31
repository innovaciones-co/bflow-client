import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/upsert_products_cubit/upsert_products_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:go_router/go_router.dart';

class ImportProductsFileWidget extends StatefulWidget {
  final int supplierId;
  final UpsertProductsCubit upsertProductsCubit;

  const ImportProductsFileWidget({
    super.key,
    required this.supplierId,
    required this.upsertProductsCubit,
  });

  @override
  State<ImportProductsFileWidget> createState() =>
      _ImportProductsFileWidgetState();
}

class _ImportProductsFileWidgetState extends State<ImportProductsFileWidget> {
  bool isHighlighted = false;
  DropzoneViewController? _controller;
  String? _selectedFile;
  List<int>? file;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
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
        _showSelectedFile(),
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
              onPressed: () =>
                  widget.upsertProductsCubit.loadProductsData(file),
              type: ButtonType.elevatedButton,
              title: "Import",
              foregroundColor: AppColor.white,
              backgroundColor: AppColor.blue,
            ),
          ],
        ),
      ],
    );
  }

  _showSelectedFile() {
    return _selectedFile != null
        ? Container(
            margin: const EdgeInsets.only(right: 7, bottom: 5),
            child: Chip(
              label: Text(_selectedFile!),
              onDeleted: () {
                setState(
                  () {
                    _selectedFile = null;
                  },
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildChooseFilesArea(BuildContext context) {
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
    var fileName = await _controller?.getFilename(value);
    var data = _controller?.getFileStream(value);

    file = await convertStreamToList(data!);

    setState(() {
      _selectedFile = fileName;
      isHighlighted = false;
    });

    debugPrint(fileName);
  } // TODO: Validate .xlsx

  Future<List<int>> convertStreamToList(Stream<List<int>> stream) async {
    // Collect all lists from the stream
    List<List<int>> listOfLists = await stream.toList();

    // Flatten the list of lists into a single list
    List<int> combinedList = listOfLists.expand((list) => list).toList();

    return combinedList;
  }

  void _onCreated(DropzoneViewController controller) {
    _controller = controller;
  }

  _cancel(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }
}
