import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  final SharedPreferences prefs;

  LocalDataSource({required this.prefs});
}
