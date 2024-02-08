import 'dart:convert';

import 'package:bflow_client/src/core/exceptions/bad_request_exception.dart';
import 'package:bflow_client/src/core/exceptions/bad_response_exception.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/shared/data/models/error_response_model.dart';
import 'package:dio/dio.dart';

import 'api.dart';

enum Methods {
  put("PUT"),
  patch("PATCH"),
  delete("DELETE"),
  post("POST"),
  get("GET");

  final String name;
  const Methods(this.name);

  @override
  String toString() => name;
}

class ApiService {
  final Dio client = Dio();

  ApiService();

  Future<dynamic> get(
      {required String endpoint, Map<String, String>? params}) async {
    final response = await _performRequest(
        Methods.get, '${ApiConstants.baseUrl}/$endpoint',
        queryParams: params);
    return response.data;
  }

  Future<dynamic> post(
      {required String endpoint, Map<String, dynamic>? data}) async {
    final response = await _performRequest(
      Methods.post,
      '${ApiConstants.baseUrl}/$endpoint',
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return response.data;
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final response = await _performRequest(
      Methods.put,
      '${ApiConstants.baseUrl}/$endpoint',
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return response.data;
  }

  Future<dynamic> patch(String endpoint, Map<String, dynamic> data) async {
    final response = await _performRequest(
      Methods.patch,
      '${ApiConstants.baseUrl}/$endpoint',
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return response.data;
  }

  Future<dynamic> delete(String endpoint, Map<String, dynamic> data) async {
    final response = await _performRequest(
      Methods.delete,
      '${ApiConstants.baseUrl}/$endpoint',
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return response.data;
  }

  Future<Response<dynamic>> _performRequest(
    Methods method,
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    String? body,
  }) async {
    try {
      final options = Options(
        method: method.toString(),
        validateStatus: (status) => status != null ? status < 500 : false,
      );
      final response = await client.request(
        url,
        options: options,
        data: body,
        queryParameters: queryParams,
      );

      switch (response.statusCode) {
        case 400:
          ErrorResponseModel? errorResponse = _getErrorResponse(response);

          throw BadRequestException(
            message: errorResponse != null
                ? errorResponse.message
                : response.data.toString(),
            errorResponse: errorResponse,
          );
        case 401:
          throw BadResponseException('Unauthorized');
        case 403:
          throw BadResponseException('Forbidden');
        case 404:
          throw BadResponseException('Not found');
      }

      return response;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.badResponse:
          throw RemoteDataSourceException(e.message ?? "BAD RESPONSE");
        default:
          throw RemoteDataSourceException('Unexpected error: ${e.message}');
      }
    }
  }

  ErrorResponseModel? _getErrorResponse(Response<dynamic> response) {
    try {
      return ErrorResponseModel.fromMap(response.data);
    } on Exception {
      return null;
    }
  }
}
