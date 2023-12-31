// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Global {
  // Varáveis Globais
  static bool isDarkTheme = false;
  static String userName = '';

  // Cores
  static Color _calculateColor(String hexDark, String hexLight,
      {double opacity = 1.0}) {
    return isDarkTheme
        ? hexToColor(hexDark, opacity: opacity)
        : hexToColor(hexLight, opacity: opacity);
  }

  static Color get backgroundColor => _calculateColor('#170034', '#E0E4F2');
  static Color get frameColor => _calculateColor('#000000', '#959595', opacity: 0.3);
  static Color get whiteColor => _calculateColor('#FFFFFF', '#FFFFFF');
  static Color get highlightTextColor => _calculateColor('#FFFF6F', '#7148cf');
  static Color get showPasswordColor => _calculateColor('#7148cf', '#7148cf');
  static Color get buttonColor => _calculateColor('#390080', '#FFFFFF');
  static Color get buttonTextColor => _calculateColor('#FFFF6F', '#170034');
  static Color get simpleTextColor => _calculateColor('#FFFFFF', '#3F525D');
  static Color get simpleTextWhiteBackgroundColor => _calculateColor('#3F525D', '#3F525D');
  static Color get iconContainerIconBackColor => _calculateColor('#390080', '#390080');
}

class Types {
  static Map<String, Color> colors = {
    'bug': hexToColor('#92BC2C'),
    'dark': hexToColor('#595761'),
    'dragon': hexToColor('#0C69C8'),
    'electric': hexToColor('#F2D94E'),
    'fire': hexToColor('#FBA54C'),
    'fairy': hexToColor('#EE90E6'),
    'fighting': hexToColor('#D3425F'),
    'flying': hexToColor('#A1BBEC'),
    'ghost': hexToColor('#5F6DBC'),
    'grass': hexToColor('#5FBD58'),
    'ground': hexToColor('#DA7C4D'),
    'ice': hexToColor('#75D0C1'),
    'normal': hexToColor('#A0A29F'),
    'poison': hexToColor('#B763CF'),
    'psychic': hexToColor('#FA8581'),
    'rock': hexToColor('#C9BB8A'),
    'steel': hexToColor('#5695A3'),
    'water': hexToColor('#539DDF'),
  };
}

Color hexToColor(String code, {double opacity = 1.0}) {
  return Color(int.parse(code.substring(1, 7), radix: 16) +
      (opacity * 255).toInt() * 0x1000000);
}

double setHeight(double height) {
  return ScreenUtil().setHeight(height);
}

double setWidth(double width) {
  return ScreenUtil().setWidth(width);
}

double setFontSize(double fontSize) {
  return ScreenUtil().setSp(fontSize);
}
