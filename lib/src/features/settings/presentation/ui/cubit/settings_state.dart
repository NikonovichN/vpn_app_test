part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final String serverAddress;
  final String login;
  final String password;

  const SettingsLoaded({required this.serverAddress, required this.login, required this.password});
}

final class SettingsError extends SettingsState {
  final SettingsRepositoryError? repositoryError;

  const SettingsError({this.repositoryError});
}
