import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vpn_app_test/src/src.dart';

class VpnAppNavigationBar extends StatelessWidget {
  final GoRouterState routerState;

  const VpnAppNavigationBar({super.key, required this.routerState});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 80.0,
      padding: const EdgeInsets.all(9.0),
      decoration: const BoxDecoration(
        color: BasicVpnAppColors.navigationBackground,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BarButton(
            //TODO: add generated svg icons
            icon: const BarIcon(iconPath: 'assets/svg/home.svg'),
            isActive: RouterPath.home.path == routerState.fullPath,
            onPressed: () => context.go(RouterPath.home.path),
          ),
          BarButton(
            icon: const BarIcon(iconPath: 'assets/svg/settings.svg'),
            isActive: RouterPath.settings.path == routerState.fullPath,
            onPressed: () => context.go(RouterPath.settings.path),
          ),
        ],
      ),
    );
  }
}

class BarButton extends StatelessWidget {
  final Widget icon;
  final bool isActive;
  final VoidCallback onPressed;

  const BarButton({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onPressed,
  });

  static const _animationDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        width: 62.0,
        height: 62.0,
        duration: _animationDuration,
        decoration: BoxDecoration(
          color: isActive ? BasicVpnAppColors.main : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(62)),
        ),
        child: AnimatedTheme(
          duration: _animationDuration,
          data: ThemeData(
            iconTheme: IconThemeData(
              color: isActive ? BasicVpnAppColors.black : BasicVpnAppColors.white,
            ),
          ),
          child: icon,
        ),
      ),
    );
  }
}

class BarIcon extends StatelessWidget {
  final String iconPath;

  const BarIcon({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            Theme.of(context).iconTheme.color!,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}
