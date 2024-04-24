import 'package:bflow_client/src/core/exceptions/invalid_argument_exception.dart';

enum TemplateType {
  task('Task', "tasks"),
  material('Material', "materials");

  final String name;
  final String pluralName;
  const TemplateType(this.name, this.pluralName);

  @override
  String toString() => name;

  String toJSON() => '${name.toUpperCase().replaceAll(' ', '_')}_TEMPLATE';

  static TemplateType fromString(String str) {
    switch (str.toLowerCase()) {
      case "task":
        return TemplateType.task;
      case "material":
        return TemplateType.material;
      default:
        return throw InvalidArgumentException(str);
    }
  }
}
