import 'package:either_dart/src/either.dart';

import '../../domain/entity/settings.dart';
import '../../domain/repository/setting_repository.dart';
import '../data_source/locale_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDataSource _dataSource;

  const SettingsRepositoryImpl({required SettingsDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<Either<SettingsRepositoryError, SettingsEntity>> read() async {
    try {
      final res = await _dataSource.read();

      if (res == null) {
        throw EmptySettingsRepositoryError;
      }

      return Right(res);
    } on EmptySettingsRepositoryError {
      return const Left(EmptySettingsRepositoryError('Empty Repository'));
    } catch (e) {
      return Left(UnknownSettingsRepositoryError('Something went wrong! $e'));
    }
  }

  @override
  Future<Either<SettingsRepositoryError, bool>> save(SettingsEntity settings) async {
    try {
      await _dataSource.save(settings);
      return const Right(true);
    } catch (e) {
      return Left(UnknownSettingsRepositoryError('Something went wrong! $e'));
    }
  }
}
