import 'package:bflow_client/src/core/data/sources/local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginValues {
  static const String token = "token";
}

class LoginLocalDataSource implements LocalDataSource {
  @override
  final SharedPreferences prefs;

  LoginLocalDataSource({required this.prefs});

  Future<String?> getToken() async {
    try {
      return prefs.getString(LoginValues.token);
    } on Exception {
      return null;
    }
  }

  Future<bool> saveToken(
    String token,
  ) async {
    return prefs.setString(LoginValues.token, token);
  }

  removeToken() {
    prefs.remove(LoginValues.token);
  }
}
