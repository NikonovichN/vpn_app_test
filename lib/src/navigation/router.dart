import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:vpn_app_test/src/features/features.dart';
import 'package:vpn_app_test/src/ui_kit/ui_kit.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum RouterPath {
  home("/home_vpn"),
  favorite("/settings"),
  ;

  const RouterPath(this.path);

  final String path;
}

final router = GoRouter(
  initialLocation: RouterPath.home.path,
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldVpnApp(child: child);
      },
      routes: [
        GoRoute(
          path: RouterPath.home.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeVPNScreen(),
          ),
        ),
        GoRoute(
          path: RouterPath.home.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),
      ],
    ),
  ],
);

class ScaffoldVpnApp extends StatelessWidget {
  static const _backgroundImage = 'assets/images/background.png';

  final Widget child;

  const ScaffoldVpnApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BasicVpnAppColors.dark,
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            OverflowBox(
              minHeight: constraints.maxHeight,
              child: const Image(
                fit: BoxFit.fitHeight,
                image: AssetImage(_backgroundImage),
              ),
            ),
            Column(
              children: [
                child,
              ],
            ),
          ],
        );
      }),
    );
  }
}
