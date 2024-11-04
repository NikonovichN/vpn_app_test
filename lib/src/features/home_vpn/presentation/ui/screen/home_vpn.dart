import 'package:flutter/material.dart';

import '../../../../../src.dart';

class HomeVPNScreen extends StatelessWidget {
  const HomeVPNScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('917 VPN', style: VpnAppFonts.appTitle),
        Text(
          'Here will be turn/off widget',
          style: VpnAppFonts.regular,
        ),
      ],
    );
  }
}
