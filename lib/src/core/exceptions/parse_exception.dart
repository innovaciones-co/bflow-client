class ParserException implements Exception {
  final String? message;

  ParserException({this.message});

  @override
  String toString() {
    return 'ParserException: $message';
  }
}
