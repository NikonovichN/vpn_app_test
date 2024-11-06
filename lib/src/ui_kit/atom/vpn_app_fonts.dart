import 'package:flutter/material.dart';

import 'vpn_app_colors.dart';

class VpnAppFonts {
  const VpnAppFonts._();

  static const defaultFontFamily = 'Poppins';

  static const TextStyle regular = TextStyle(
    fontSize: 24,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.normal,
    color: BasicVpnAppColors.main,
  );

  static const TextStyle regularBold = TextStyle(
    fontSize: 24,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w500,
    color: BasicVpnAppColors.main,
  );

  static const TextStyle appTitle = TextStyle(
    fontSize: 48,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w500,
    color: BasicVpnAppColors.main,
  );

  static const TextStyle inputHelper = TextStyle(
    fontSize: 16,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: BasicVpnAppColors.white,
  );

  static const TextStyle primaryButton = TextStyle(
    fontSize: 16,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w600,
  );
}
