import 'package:bflow_client/src/features/users/data/models/user_model.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_role.dart';

import '../../../../core/api/api.dart';

class UsersRemoteDataSource {
  final ApiService apiService;

  UsersRemoteDataSource({required this.apiService});

  Future<UsersModel> fetchUser(int userId) async {
    Map<String, dynamic> response = await apiService.get(
        endpoint:
            ApiConstants.userEndpoint.replaceAll(":id", userId.toString()));

    return UsersModel.fromMap(response);
  }

  Future<List<UsersModel>> fetchUsers() async {
    List<dynamic> response =
        await apiService.get(endpoint: ApiConstants.usersEndpoint);
    return response.map((e) => UsersModel.fromMap(e)).toList();
  }

  Future<List<UsersModel>> fetchSupervisors() async {
    List<dynamic> response =
        await apiService.get(endpoint: ApiConstants.usersEndpoint);
    return response
        .map((e) => UsersModel.fromMap(e))
        .toList()
        .where((element) => element.role == UserRole.supervisor)
        .toList();
  }

  Future<UsersModel> updateUser(User user) async {
    var userModel = UsersModel.fromEntity(user);

    int userId = await apiService.put(
      endpoint:
          ApiConstants.userEndpoint.replaceAll(':id', user.id!.toString()),
      data: userModel.toMap(),
    );
    return fetchUser(userId);
  }

  Future<UsersModel> createUser(User user) async {
    var userModel = UsersModel.fromEntity(user);

    int userId = await apiService.post(
      endpoint: ApiConstants.usersEndpoint,
      data: userModel.toMap(),
    );
    return fetchUser(userId);
  }
}
