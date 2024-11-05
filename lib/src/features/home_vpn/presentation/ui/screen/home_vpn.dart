import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../src.dart';

class HomeVPNScreen extends StatelessWidget {
  const HomeVPNScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VpnCubit, VpnState>(
      builder: (context, state) {
        return Column(
          children: [
            const Text('917 VPN', style: VpnAppFonts.appTitle),
            SizedBox(
              width: double.infinity,
              child: VpnAppButton.primary(
                onPressed: context.read<VpnCubit>().start,
                child: const Text('Start VPN'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: VpnAppButton.primary(
                onPressed: context.read<VpnCubit>().stop,
                child: const Text('Stop VPN'),
              ),
            ),
          ],
        );
      },
    );
  }
}
