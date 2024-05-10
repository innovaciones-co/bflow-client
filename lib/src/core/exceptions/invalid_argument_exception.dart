class InvalidArgumentException implements Exception {
  final String message;

  InvalidArgumentException(this.message);

  @override
  String toString() {
    return "Invalid argument exception: $message";
  }
}
