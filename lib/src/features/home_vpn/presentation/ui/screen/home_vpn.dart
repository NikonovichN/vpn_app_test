import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../src.dart';
import '../widgets/swithcer.dart';

class HomeVPNScreen extends StatelessWidget {
  // TODO: should be intl
  static const _textConnected = 'Connected';
  static const _titleApp = '917 VPN';

  const HomeVPNScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VpnCubit, VpnState>(
      builder: (context, state) {
        final isConnected = state.stage == StageVpnStatus.connected.name;
        final isWaitingConnection = state.stage != StageVpnStatus.connected.name &&
            state.stage != StageVpnStatus.disconnected.name;

        return Column(
          children: [
            SizedBox(height: isDesktop ? 96.0 : (68.0 + MediaQuery.paddingOf(context).top)),
            const Text(_titleApp, style: VpnAppFonts.appTitle),
            const Spacer(),
            isWaitingConnection
                ? const SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: CircularProgressIndicator(
                      color: BasicVpnAppColors.main,
                      strokeWidth: 10.0,
                    ),
                  )
                : _Switcher(isConnected: isConnected),
            const SizedBox(height: 40.0),
            SizedBox(
              height: 68.0,
              child: !isConnected || state.status?.duration == null
                  ? null
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _textConnected,
                          style: VpnAppFonts.regularBold.copyWith(color: BasicVpnAppColors.main),
                        ),
                        Text(
                          state.status!.duration.toString(),
                          style: VpnAppFonts.regular.copyWith(color: BasicVpnAppColors.main),
                        ),
                      ],
                    ),
            ),
            const Spacer(),
          ],
        );
      },
    );
  }
}

class _Switcher extends StatelessWidget {
  // TODO: should be intl
  static const _titleDialog = 'Settings';
  static const _descriptionDialog =
      'Something went wrong with settings. Please try to update configuration!';
  static const _closeButton = 'Close';
  static const _goButton = 'Go';

  final bool isConnected;

  const _Switcher({required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Switcher(
          isConnected: isConnected,
          onPressed: state is SettingsLoaded
              ? isConnected
                  ? context.read<VpnCubit>().stop
                  : context.read<VpnCubit>().start
              : () => _dialogBuilder(context),
        );
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BasicVpnAppColors.dark,
          title: const Text(_titleDialog, style: VpnAppFonts.appTitle),
          content: const Text(_descriptionDialog, style: VpnAppFonts.regular),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: VpnAppFonts.regularBold.copyWith(color: BasicVpnAppColors.main),
              ),
              child: const Text(_closeButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: VpnAppFonts.regularBold.copyWith(color: BasicVpnAppColors.main),
              ),
              child: const Text(_goButton),
              onPressed: () {
                Navigator.of(context).pop();
                context.go(RouterPath.settings.path);
              },
            ),
          ],
        );
      },
    );
  }
}
