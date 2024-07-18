class RemoteDataSourceException implements Exception {
  final String message;

  RemoteDataSourceException(this.message);

  @override
  String toString() {
    return 'RemoteDataSourceException: $message';
  }
}
