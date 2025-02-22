import 'package:vpn_app_test/src/managers/shared_preferences_manager.dart';
import '../../domain/entity/settings.dart';

abstract class SettingsDataSource {
  Future<SettingsEntity?> read();
  Future<void> save(SettingsEntity settings);
}

class LocaleSettingsDataSourceImpl implements SettingsDataSource {
  static const _vpnConnectSettingsKey = 'vpn_connect_settings';

  final SharedPreferencesManager _prefs;

  LocaleSettingsDataSourceImpl({required SharedPreferencesManager prefsManager})
      : _prefs = prefsManager;

  @override
  Future<SettingsEntity?> read() {
    final res = _prefs.readString(_vpnConnectSettingsKey);

    if (res == null) {
      return Future.value(null);
    }

    final values = res.split(',');

    return Future.value(
      SettingsEntity(
        // TODO: add deserealization
        serverAddress: values[0],
        login: values[1],
        password: values[2],
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
