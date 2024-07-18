import 'package:bflow_client/src/features/shared/data/models/error_response_model.dart';

class BadRequestException implements Exception {
  final String? message;
  ErrorResponseModel? errorResponse;

  BadRequestException({this.message, this.errorResponse});

  @override
  String toString() {
    if (errorResponse == null) {
      return message ?? 'Bad request';
    }

    if (errorResponse!.fieldErrors != null &&
        errorResponse!.fieldErrors!.isNotEmpty) {
      return "${errorResponse?.fieldErrors?.first.message}";
    }

    return errorResponse!.message ?? "Bad request";
  }
}
