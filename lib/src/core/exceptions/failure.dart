abstract class Failure {
  final String? message;

  Failure({this.message});
}

class ServerFailure extends Failure {
  @override
  final String? message;

  ServerFailure({this.message});
}

class NotFoundFailure extends Failure {}

class ClientFailure extends Failure {}
