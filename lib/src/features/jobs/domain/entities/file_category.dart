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

  static FileCategory fromString(String str) {
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
}
