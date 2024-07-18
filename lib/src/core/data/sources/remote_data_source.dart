import 'package:bflow_client/src/core/api/api_service.dart';

abstract class RemoteDataSource {
  final ApiService apiService;

  RemoteDataSource({required this.apiService});
}
