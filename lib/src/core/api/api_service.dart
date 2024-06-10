import 'dart:convert';

import 'package:bflow_client/src/core/exceptions/bad_request_exception.dart';
import 'package:bflow_client/src/core/exceptions/bad_response_exception.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/shared/data/models/error_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  SharedPreferences sharedPreferences;

  ApiService({
    required this.sharedPreferences,
  });

  String? get token => sharedPreferences.get('token') as String?;

  Future<dynamic> get(
      {required String endpoint, Map<String, String>? params}) async {
    final response = await _performRequest(
      Methods.get,
      '${ApiConstants.baseUrl}/$endpoint',
      queryParams: params,
    );
    return response.data;
  }

  Future<dynamic> post({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParams,
    bool encodeJson = true,
    bool formData = false,
    Map<String, String>? headers = const {'Content-Type': 'application/json'},
  }) async {
    final response = await _performRequest(
      Methods.post,
      '${ApiConstants.baseUrl}/$endpoint',
      body: !formData
          ? (encodeJson ? jsonEncode(data) : data)
          : FormData.fromMap(data!),
      queryParams: queryParams,
      headers: headers,
    );
    return response.data;
  }

  Future<dynamic> put({required String endpoint, dynamic data}) async {
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

  Future<dynamic> delete(
      {required String endpoint,
      Map<String, String>? params,
      Map<String, dynamic>? data}) async {
    final response = await _performRequest(
      Methods.delete,
      '${ApiConstants.baseUrl}/$endpoint',
      queryParams: params,
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
    dynamic body,
  }) async {
    try {
      if (token != null) {
        headers ??= {};
        headers['Authorization'] = "Bearer $token";
      }

      final options = Options(
        method: method.toString(),
        validateStatus: (status) => status != null ? status <= 500 : false,
        headers: headers,
      );

      debugPrint("Request to: ${url.toString()}");
      debugPrint("Body: ${body.toString()}");

      final response = await client.request(
        url,
        options: options,
        data: body,
        queryParameters: queryParams,
      );

      // debugPrint("Status code: ${response.statusCode.toString()}");
      debugPrint("Response: ${response.toString()}");

      switch (response.statusCode) {
        case 500:
          ErrorResponseModel? errorResponse = _getErrorResponse(response);

          throw BadResponseException(
              errorResponse?.message ?? "Server failure");
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
        case 413:
          throw BadResponseException('Maximum upload size exceeded');
      }

      return response;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.badResponse:
          throw RemoteDataSourceException(e.message ?? "BAD RESPONSE");
        default:
          throw RemoteDataSourceException('Unexpected error: ${e.message}');
      }
    } on BadResponseException catch (e) {
      throw RemoteDataSourceException(e.message ?? "Unexpected error");
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
