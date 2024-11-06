import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:vpn_app_test/src/src.dart';

part 'vpn_state.dart';

class VpnCubit extends Cubit<VpnState> {
  late OpenVPN engine;

  final SettingsRepository _settingsRepository;

  VpnCubit({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(const VpnState()) {
    engine = OpenVPN(
      onVpnStatusChanged: _onVpnStatusChanged,
      onVpnStageChanged: _onVpnStageChanged,
    );
  }

  void _onVpnStatusChanged(VpnStatus? status) {
    emit(state.copyWith(status: status));
  }

  void _onVpnStageChanged(VPNStage _, String stage) {
    emit(state.copyWith(stage: stage));
  }

  Future<void> initialize() async {
    await engine.requestPermissionAndroid().then((onValue) {
      emit(state.copyWith(granted: onValue));
    }).catchError((error) {
      emit(state.copyWith(granted: false));
    });

    await engine.initialize(
      groupIdentifier: "group.com.laskarmedia.vpn",
      providerBundleIdentifier: "id.laskarmedia.openvpnFlutterExample.VPNExtension",
      localizedDescription: "VPN by Nizwar",
      lastStage: (stage) => _onVpnStageChanged(stage, stage.name),
      lastStatus: (status) => _onVpnStatusChanged(status),
    );
  }

  Future<void> start() async {
    final settings = await _settingsRepository.read();

    if (settings.isLeft) {
      return;
    }

    var config = await rootBundle.loadString('assets/open_vpn_config.ovpn');

    // WITH OPEN VPN I STUCK WITH ISSUE
    // https://github.com/nizwar/openvpn_flutter/issues/122
    if (config.contains('cipher AES-128-CBC') && !config.contains('data-ciphers')) {
      config = config.replaceAll('cipher AES-128-CBC', '''cipher AES-128-CBC
    data-ciphers 'AES-128-CBC'
    data-ciphers-fallback 'AES-128-CBC\'''');
    }
    if (config.contains('cipher AES-256-CBC') && !config.contains('data-ciphers')) {
      config = config.replaceAll('cipher AES-256-CBC', '''cipher AES-256-CBC
    data-ciphers 'AES-256-CBC'
    data-ciphers-fallback 'AES-256-CBC\'''');
    }

    engine.connect(
      config,
      settings.right.serverAddress,
      username: settings.right.login,
      password: settings.right.password,
      certIsRequired: true,
    );
  }

  void stop() async {
    engine.disconnect();
    emit(state.copyWith(status: null, stage: null));
  }
}

enum StageVpnStatus {
  connected,
  wait_connection,
  disconnected,
  authenticating,
  vpn_generate_config
}
