import 'package:flutter/material.dart';

import 'package:vpn_app_test/src/src.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '917 VPN',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: VpnAppFonts.defaultFontFamily,
      ),
      routerConfig: router,
    );
  }
}
