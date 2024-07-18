import 'package:bflow_client/src/core/exceptions/invalid_argument_exception.dart';

enum FileCategory {
  document('Document'),
  photo('Photo'),
  plan('Plan');

  final String name;
  const FileCategory(this.name);

  @override
  String toString() => name;

  String toJSON() => name.toUpperCase().replaceAll(' ', '_');

  factory FileCategory.fromString(String str) {
    switch (str.toLowerCase()) {
      case "document":
        return FileCategory.document;
      case "photo":
        return FileCategory.photo;
      case "plan":
        return FileCategory.plan;
      default:
        throw InvalidArgumentException(str);
    }
  }

  factory FileCategory.fromExtension(String fileExtension) {
    switch (fileExtension.toLowerCase()) {
      case 'pdf':
      case 'doc':
      case 'docx':
      case 'txt':
        return FileCategory.document;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return FileCategory.photo;
      case 'dwg':
      case 'dxf':
        return FileCategory.plan;
      default:
        return FileCategory.document;
    }
  }
}
