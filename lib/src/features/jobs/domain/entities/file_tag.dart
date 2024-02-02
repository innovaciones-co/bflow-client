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

  static FileTag fromString(String str) {
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
}
