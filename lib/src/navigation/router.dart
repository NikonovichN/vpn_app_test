import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'scaffold_vpn_app.dart';
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
        return ScaffoldVpnApp(routerState: state, child: child);
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
