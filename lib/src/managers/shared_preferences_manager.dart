import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesManager {
  Future<void> setString(String key, String value);

  String? readString(String key);
}

class SharedPreferencesManagerImpl implements SharedPreferencesManager {
  final SharedPreferences _prefs;

  SharedPreferencesManagerImpl({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  String? readString(String key) => _prefs.getString(key);
}
