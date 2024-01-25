abstract class Failure {
  final String? message;

  Failure({this.message});
}

class ServerFailure extends Failure {
  ServerFailure({super.message});
}

class NotFoundFailure extends Failure {}

class ClientFailure extends Failure {}
