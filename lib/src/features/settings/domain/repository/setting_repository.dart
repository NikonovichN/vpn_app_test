import 'package:either_dart/either.dart';

import '../entity/settings.dart';

sealed class SettingsRepositoryError {
  final String message;

  const SettingsRepositoryError({required this.message});
}

class EmptySettingsRepositoryError implements SettingsRepositoryError {
  final String _message;

  const EmptySettingsRepositoryError(String message) : _message = message;

  @override
  String get message => _message;
}

class UnknownSettingsRepositoryError implements SettingsRepositoryError {
  final String _message;

  const UnknownSettingsRepositoryError(String message) : _message = message;

  @override
  String get message => _message;
}

abstract class SettingsRepository {
  Future<Either<SettingsRepositoryError, bool>> save(SettingsEntity settings);
  Future<Either<SettingsRepositoryError, SettingsEntity>> read();
}
