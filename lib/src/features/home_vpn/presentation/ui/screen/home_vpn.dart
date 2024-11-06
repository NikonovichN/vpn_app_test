import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../src.dart';
import '../widgets/swithcer.dart';

class HomeVPNScreen extends StatelessWidget {
  static const _textConnected = 'Connected';

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
            const Text('917 VPN', style: VpnAppFonts.appTitle),
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
                : Switcher(
                    isConnected: isConnected,
                    onPressed: isConnected
                        ? context.read<VpnCubit>().stop
                        : context.read<VpnCubit>().start,
                  ),
            const SizedBox(height: 40.0),
            SizedBox(
              height: 68.0,
              child: !isConnected
                  ? null
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _textConnected,
                          style: VpnAppFonts.regularBold.copyWith(color: BasicVpnAppColors.main),
                        ),
                        Text(
                          state.status?.duration.toString() ?? '',
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
