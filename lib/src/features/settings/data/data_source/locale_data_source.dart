import 'package:vpn_app_test/src/managers/shared_preferences_manager.dart';
import '../../domain/entity/settings.dart';

abstract class DataSource {
  Future<SettingsEntity?> read();
  Future<void> save(SettingsEntity settings);
}

class LocaleDataSourceImpl implements DataSource {
  static const _vpnConnectSettingsKey = 'vpn_connect_settings';

  final SharedPreferencesManager _prefs;

  LocaleDataSourceImpl({required SharedPreferencesManager prefsManager}) : _prefs = prefsManager;

  @override
  Future<SettingsEntity?> read() {
    final res = _prefs.readString(_vpnConnectSettingsKey);

    if (res == null) {
      return Future.value(null);
    }

    return Future.value(
      SettingsEntity(
        // TODO: add deserealization
        serverAddress: res[0],
        login: res[1],
        password: res[2],
      ),
    );
  }

  @override
  Future<void> save(SettingsEntity settings) {
    return _prefs.setString(
      _vpnConnectSettingsKey,
      '${settings.serverAddress},${settings.login},${settings.password}',
    );
  }
}
