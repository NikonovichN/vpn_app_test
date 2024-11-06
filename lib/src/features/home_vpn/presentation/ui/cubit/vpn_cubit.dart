import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

part 'vpn_state.dart';

class VpnCubit extends Cubit<VpnState> {
  late OpenVPN engine;

  VpnCubit() : super(const VpnState()) {
    engine = OpenVPN(
      onVpnStatusChanged: _onVpnStatusChanged,
      onVpnStageChanged: _onVpnStageChanged,
    );
  }

  void _onVpnStatusChanged(VpnStatus? status) {
    print('vpn_status: status ${status}');
    emit(state.copyWith(status: status));
  }

  void _onVpnStageChanged(VPNStage _, String stage) {
    print('vpn_status: stage ${stage}');
    emit(state.copyWith(stage: stage));
  }

  Future<void> initialize() async {
    await engine.requestPermissionAndroid().then((onValue) {
      print('vpn_status: granted - $onValue');
      emit(state.copyWith(granted: onValue));
    }).catchError((error) {
      print('vpn_status: granted error - $error');
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
    var config = await rootBundle.loadString('assets/open_vpn_config.ovpn');

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
      "MY VPN",
      username: "vpn",
      password: "vpn",
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
