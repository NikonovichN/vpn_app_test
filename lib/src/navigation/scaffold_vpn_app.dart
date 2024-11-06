import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/features.dart';
import '../ui_kit/ui_kit.dart';
import 'package:vpn_app_test/src/di/injections.dart';

import 'navigation_bar.dart';

class ScaffoldVpnApp extends StatelessWidget {
  static const _backgroundImage = 'assets/images/background.png';

  final Widget child;
  final GoRouterState routerState;
  const ScaffoldVpnApp({super.key, required this.child, required this.routerState});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          create: (_) => injector<SettingsCubit>()..load(),
        ),
        BlocProvider<VpnCubit>(
          create: (_) => injector<VpnCubit>()..initialize(),
        ),
      ],
      child: Scaffold(
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
                    children: [
                      Flexible(child: child),
                      VpnAppNavigationBar(routerState: routerState),
                      const SizedBox(height: 40.0),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
