import 'package:bflow_client/src/features/shared/data/models/error_response_model.dart';

abstract class Failure {
  final String? message;

  Failure({this.message});
}

class ServerFailure extends Failure {
  ServerFailure({super.message});
}

class NotFoundFailure extends Failure {}

class ClientFailure extends Failure {
  final ErrorResponseModel? errorResponse;

  ClientFailure({super.message, this.errorResponse});
}
