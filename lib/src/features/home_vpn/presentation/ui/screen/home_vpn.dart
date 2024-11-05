import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../src.dart';
import '../../widgets/swithcer.dart';

class HomeVPNScreen extends StatelessWidget {
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
            const Spacer(),
          ],
        );
      },
    );
  }
}
