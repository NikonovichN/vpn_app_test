import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:vpn_app_test/src/src.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum RouterPath {
  home("/home_vpn"),
  settings("/settings"),
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
          path: RouterPath.settings.path,
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
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    child,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () => context.go(RouterPath.home.path),
                          child: const Text('Home'),
                        ),
                        ElevatedButton(
                          onPressed: () => context.go(RouterPath.settings.path),
                          child: const Text('Settings'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
