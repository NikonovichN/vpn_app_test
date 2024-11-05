import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../features/features.dart';
import '../managers/shared_preferences_manager.dart';

final GetIt injector = GetIt.instance;

class DependencyInjections {
  const DependencyInjections();

  Future<void> registerDependencies() async {
    // Stuff
    injector.registerSingleton<SharedPreferencesManager>(
      SharedPreferencesManagerImpl(
        prefs: await SharedPreferences.getInstance(),
      ),
    );

    // Data sources
    injector.registerSingleton<SettingsDataSource>(
        LocaleSettingsDataSourceImpl(prefsManager: injector()));

    // Repositories
    injector.registerSingleton<SettingsRepository>(SettingsRepositoryImpl(dataSource: injector()));

    // Blocs
    injector.registerSingleton<SettingsCubit>(SettingsCubit(repository: injector()));
  }
}
