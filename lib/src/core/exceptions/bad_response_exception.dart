class BadResponseException implements Exception {
  final String? message;

  BadResponseException(this.message);

  @override
  String toString() {
    return 'BadResponseException: $message';
  }
}
