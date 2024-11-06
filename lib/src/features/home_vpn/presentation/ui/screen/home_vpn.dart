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
        final isConnected = state.status?.connectedOn != null;

        return Column(
          children: [
            SizedBox(height: isDesktop ? 96.0 : (68.0 + MediaQuery.paddingOf(context).top)),
            const Text('917 VPN', style: VpnAppFonts.appTitle),
            const Spacer(),
            Switcher(
              isConnected: isConnected,
              onPressed:
                  isConnected ? context.read<VpnCubit>().stop : context.read<VpnCubit>().start,
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
                          '00:01:35',
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
