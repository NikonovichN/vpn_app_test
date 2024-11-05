import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:vpn_app_test/src/src.dart';
import 'package:vpn_app_test/src/di/injections.dart';

class ScaffoldVpnApp extends StatelessWidget {
  static const _backgroundImage = 'assets/images/background.png';

  final Widget child;

  const ScaffoldVpnApp({super.key, required this.child});

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
      ),
    );
  }
}
