import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';

import 'api.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

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

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _performRequest(
          Methods.get, '${ApiConstants.baseUrl}/$endpoint');
      return response.data;
    } on SocketException {
      throw RemoteDataSourceException('No internet connection');
    } on HttpException {
      throw RemoteDataSourceException('HTTP error');
    } on FormatException {
      throw RemoteDataSourceException('Invalid response format');
    } catch (e) {
      throw RemoteDataSourceException('Unexpected error: $e');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _performRequest(
        Methods.post,
        '${ApiConstants.baseUrl}/$endpoint',
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      return response.data;
    } on SocketException {
      throw RemoteDataSourceException('No internet connection');
    } on HttpException {
      throw RemoteDataSourceException('HTTP error');
    } on FormatException {
      throw RemoteDataSourceException('Invalid response format');
    } catch (e) {
      throw RemoteDataSourceException('Unexpected error: $e');
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _performRequest(
        Methods.put,
        '${ApiConstants.baseUrl}/$endpoint',
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      return response.data;
    } on SocketException {
      throw RemoteDataSourceException('No internet connection');
    } on HttpException {
      throw RemoteDataSourceException('HTTP error');
    } on FormatException {
      throw RemoteDataSourceException('Invalid response format');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _performRequest(
        Methods.patch,
        '${ApiConstants.baseUrl}/$endpoint',
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      return response.data;
    } on SocketException {
      throw RemoteDataSourceException('No internet connection');
    } on HttpException {
      throw RemoteDataSourceException('HTTP error');
    } on FormatException {
      throw RemoteDataSourceException('Invalid response format');
    } catch (e) {
      throw RemoteDataSourceException('Unexpected error: $e');
    }
  }

  Future<dynamic> delete(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _performRequest(
        Methods.delete,
        '${ApiConstants.baseUrl}/$endpoint',
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      return response.data;
    } on SocketException {
      throw RemoteDataSourceException('No internet connection');
    } on HttpException {
      throw RemoteDataSourceException('HTTP error');
    } on FormatException {
      throw RemoteDataSourceException('Invalid response format');
    } catch (e) {
      throw RemoteDataSourceException('Unexpected error: $e');
    }
  }

  Future<Response<dynamic>> _performRequest(
    Methods method,
    String url, {
    Map<String, String>? headers,
    String? body,
  }) async {
    try {
      final options = Options(method: method.toString());
      final response = await client.request(url, options: options, data: body);
      return response;
    } on DioException catch (e) {
      throw RemoteDataSourceException('Unexpected error: ${e.message}');
    }
  }
}
