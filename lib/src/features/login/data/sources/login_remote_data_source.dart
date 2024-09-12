import 'package:bflow_client/src/features/login/data/models/auth_model.dart';

import '../../../../core/api/api.dart';

class LoginRemoteDataSource {
  final ApiService apiService;

  LoginRemoteDataSource({required this.apiService});

  Future<AuthModel> loginUser(String username, String password) async {
    Map<String, dynamic> response = await apiService.post(
      endpoint: ApiConstants.loginUsersEndpoint,
      data: {
        'username': username,
        'password': password,
      },
    );
    return AuthModel.fromMap(response);
  }

  Future<void> recoverPassword(String username) async {
    await apiService.post(
      endpoint: ApiConstants.recoverPasswordEndpoint,
      data: {
        'username': username,
      },
    );
  }

  Future<void> setNewPassword(String token, String password) async {
    await apiService.post(
      endpoint: ApiConstants.setNewPasswordEndpoint,
      data: {
        'token': token,
        'password': password,
      },
    );
  }
}
