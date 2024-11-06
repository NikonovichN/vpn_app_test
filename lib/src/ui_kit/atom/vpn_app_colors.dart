import 'package:flutter/material.dart';

class BasicVpnAppColors {
  const BasicVpnAppColors._();

  static const Color dark = Color.fromRGBO(24, 22, 22, 1.0);
  static const Color white = Color.fromRGBO(255, 255, 255, 1.0);
  static const Color black = Color.fromRGBO(0, 0, 0, 1.0);
  static const Color grey = Color.fromRGBO(109, 109, 109, 1);
  static const Color main = Color.fromRGBO(219, 248, 122, 1.0);

  static const Color borderSwitcher = Color.fromRGBO(219, 248, 122, .4);
  static const Color switcherDisabled = Color.fromRGBO(219, 248, 122, .3);
  static const Color switcherEnabled = main;
  static const Color switcherTextOff = Color.fromRGBO(255, 255, 255, 0.4);
  static const Color switcherTextOn = white;

  static const Color navigationBackground = Color.fromRGBO(86, 86, 86, 0.4);

  static const Color mainPressed = Color.fromRGBO(233, 253, 168, 1);
  static const Color mainDisabled = Color.fromARGB(255, 224, 228, 211);

  static const Color textForm = Color.fromRGBO(255, 255, 255, 0.05);

  static const Color buttonBackgroundPrimaryEnabled = main;
  static const Color buttonBackgroundPrimaryPressed = mainPressed;
  static const Color buttonBackgroundDisabled = mainDisabled;
  static const Color buttonLabelPrimary = black;
  static const Color buttonLabelDisabled = grey;
}
