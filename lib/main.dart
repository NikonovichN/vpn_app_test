import 'package:flutter/material.dart';

import 'package:vpn_app_test/src/src.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await const DependencyInjections().registerDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '917 VPN',
      theme: ThemeData(
        primaryColor: BasicVpnAppColors.main,
        fontFamily: VpnAppFonts.defaultFontFamily,
      ),
      routerConfig: router,
    );
  }
}
