import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  final String serverAddress;
  final String login;
  final String password;

  const SettingsEntity({
    required this.login,
    required this.password,
    required this.serverAddress,
  });

  @override
  List<Object?> get props => [serverAddress, login, password];
}
