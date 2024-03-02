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
      String? fieldName = errorResponse?.fieldErrors?.first.field;

      return fieldName != null
          ? "$fieldName! ${errorResponse?.fieldErrors?.first.message}"
          : "${errorResponse?.fieldErrors?.first.message}";
    }

    return errorResponse!.message ?? "Bad request";
  }
}
