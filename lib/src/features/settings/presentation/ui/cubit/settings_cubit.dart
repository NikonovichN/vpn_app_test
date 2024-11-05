import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/settings.dart';
import '../../../domain/repository/setting_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repository;

  SettingsCubit({required SettingsRepository repository})
      : _repository = repository,
        super(SettingsInitial());

  Future<void> save({
    required String serverAddress,
    required String login,
    required String password,
  }) async =>
      await _repository.save(SettingsEntity(
        serverAddress: serverAddress,
        login: login,
        password: password,
      ));

  Future<void> load() async {
    emit(SettingsLoading());

    final res = await _repository.read();

    res.fold(
      (error) => emit(SettingsError(repositoryError: error)),
      (entity) => emit(
        SettingsLoaded(
          serverAddress: entity.serverAddress,
          login: entity.login,
          password: entity.password,
        ),
      ),
    );
  }
}
