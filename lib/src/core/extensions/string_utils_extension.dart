extension StringUtilsExtension on String {
  bool search(String filter) => toLowerCase().contains(filter.toLowerCase());

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
