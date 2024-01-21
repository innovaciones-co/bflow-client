extension StringUtilsExtension on String {
  bool search(String filter) => toLowerCase().contains(filter.toLowerCase());
}
