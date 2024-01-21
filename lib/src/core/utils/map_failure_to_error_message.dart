import '../exceptions/failure.dart';

String mapFailureToErrorMessage(Failure failure) {
  final errorMessages = {
    ServerFailure: "There was a server failure",
    NotFoundFailure: "Not found",
    ClientFailure: "Unexpected error in client side",
  };

  return errorMessages[failure.runtimeType] ?? "Unexpected error";
}
