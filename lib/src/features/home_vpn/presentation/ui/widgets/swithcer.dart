import 'package:flutter/material.dart';
import 'package:vpn_app_test/src/src.dart';

class Switcher extends StatefulWidget {
  final void Function() onPressed;
  final bool isConnected;

  const Switcher({super.key, required this.onPressed, required this.isConnected});

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> with SingleTickerProviderStateMixin {
  // TODO: should be intl
  static const _offText = 'Off';
  static const _onText = 'On';
  static const _animationDuration = Duration(milliseconds: 300);

  late Animation<Alignment> _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    _circleAnimation = AlignmentTween(
      begin: widget.isConnected ? Alignment.topCenter : Alignment.bottomCenter,
      end: widget.isConnected ? Alignment.bottomCenter : Alignment.topCenter,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 202.0,
      width: 132.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.transparent,
        border: Border.all(
          color: BasicVpnAppColors.borderSwitcher,
          width: 16.0,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          if (_animationController.isCompleted) {
            _animationController.reverse();
          } else {
            _animationController.forward();
          }
          widget.onPressed();
        },
        child: Stack(
          children: [
            if (!widget.isConnected)
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  _offText.toUpperCase(),
                  style: VpnAppFonts.regular.copyWith(
                    color: BasicVpnAppColors.switcherTextOff,
                  ),
                ),
              ),
            Align(
              alignment: _circleAnimation.value,
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: widget.isConnected
                      ? BasicVpnAppColors.switcherEnabled
                      : BasicVpnAppColors.switcherDisabled,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            if (widget.isConnected)
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  _onText.toUpperCase(),
                  style: VpnAppFonts.regular.copyWith(
                    color: BasicVpnAppColors.switcherTextOn,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
