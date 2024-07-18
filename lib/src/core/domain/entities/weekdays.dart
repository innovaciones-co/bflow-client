import 'package:bflow_client/src/core/extensions/string_utils_extension.dart';

enum WeekDays {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  @override
  String toString() => name.capitalize();
}
