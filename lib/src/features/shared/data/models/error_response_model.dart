import 'dart:convert';

class ErrorResponseModel {
  final int? httpStatus;
  final String? exception;
  final String? message;
  final List<FieldError>? fieldErrors;

  ErrorResponseModel({
    this.httpStatus,
    this.exception,
    this.message,
    this.fieldErrors,
  });

  factory ErrorResponseModel.fromJson(String str) =>
      ErrorResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ErrorResponseModel.fromMap(Map<String, dynamic> json) =>
      ErrorResponseModel(
        httpStatus: json["httpStatus"],
        exception: json["exception"],
        message: json["message"],
        fieldErrors: json["fieldErrors"] == null
            ? []
            : List<FieldError>.from(
                json["fieldErrors"]!.map((x) => FieldError.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "httpStatus": httpStatus,
        "exception": exception,
        "message": message,
        "fieldErrors": fieldErrors == null
            ? []
            : List<dynamic>.from(fieldErrors!.map((x) => x.toMap())),
      };
}

class FieldError {
  final String? field;
  final String? errorCode;
  final String? message;

  FieldError({
    this.field,
    this.errorCode,
    this.message,
  });

  factory FieldError.fromJson(String str) =>
      FieldError.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FieldError.fromMap(Map<String, dynamic> json) => FieldError(
        field: json["field"],
        errorCode: json["errorCode"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "field": field,
        "errorCode": errorCode,
        "message": message,
      };
}
