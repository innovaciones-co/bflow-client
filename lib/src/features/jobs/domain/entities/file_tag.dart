import 'package:bflow_client/src/core/exceptions/invalid_argument_exception.dart';

enum FileTag {
  purchaseOrder('Purchase Order'),
  contract('Contract'),
  plan('Plan'),
  other('Other');

  final String name;
  const FileTag(this.name);

  @override
  String toString() => name;

  String toJSON() => name.toUpperCase().replaceAll(' ', '_');

  factory FileTag.fromString(String str) {
    switch (str.toLowerCase()) {
      case "purchase_order":
        return FileTag.purchaseOrder;
      case "contract":
        return FileTag.contract;
      case "plan":
        return FileTag.plan;
      case "other":
        return FileTag.other;
      default:
        throw InvalidArgumentException(str);
    }
  }

  factory FileTag.fromFilename(String fileName) {
    String lowerCaseFileName = fileName.toLowerCase();

    if (lowerCaseFileName.startsWith('po') ||
        lowerCaseFileName.contains('purchase order')) {
      return FileTag.purchaseOrder;
    } else if (lowerCaseFileName.contains('contract')) {
      return FileTag.contract;
    } else if (lowerCaseFileName.contains('plan') ||
        lowerCaseFileName.endsWith('dwg') ||
        lowerCaseFileName.endsWith('dxf')) {
      return FileTag.plan;
    } else {
      return FileTag.other;
    }
  }
}
