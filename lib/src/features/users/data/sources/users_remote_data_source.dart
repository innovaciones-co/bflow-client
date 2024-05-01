import 'package:bflow_client/src/features/users/data/models/user_model.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_role.dart';

import '../../../../core/api/api.dart';

class UsersRemoteDataSource {
  final ApiService apiService;

  UsersRemoteDataSource({required this.apiService});

  Future<List<UsersModel>> fetchUsers() async {
    List<dynamic> response =
        await apiService.get(endpoint: ApiConstants.listUsersEndpoint);
    return response.map((e) => UsersModel.fromMap(e)).toList();
  }

  Future<List<UsersModel>> fetchSupervisors() async {
    List<dynamic> response =
        await apiService.get(endpoint: ApiConstants.listUsersEndpoint);
    return response
        .map((e) => UsersModel.fromMap(e))
        .toList()
        .where((element) => element.role == UserRole.supervisor)
        .toList();
  }
}
