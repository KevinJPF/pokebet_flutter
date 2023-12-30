// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeProvider extends InheritedWidget {
  final bool isDarkTheme;
  final Widget child;

  ThemeProvider({required this.isDarkTheme, required this.child})
      : super(child: child);

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return isDarkTheme != oldWidget.isDarkTheme;
  }
}

class Global {
  // Varáveis Globais
  static bool isDarkTheme = false;

  // Cores
  static Color calculateColor(String hexDark, String hexLight,
      {double opacity = 1.0}) {
    return isDarkTheme
        ? hexToColor(hexDark, opacity: opacity)
        : hexToColor(hexLight, opacity: opacity);
  }

  static Color backgroundColor = calculateColor('#170034', '#E0E4F2');
  static Color frameColor = calculateColor('#000000', '#959595', opacity: 0.3);
  static Color highlightTextColor = calculateColor('#FFFF6F', '#7148cf');
  static Color buttonColor = calculateColor('#390080', '#FFFFFF');
  static Color buttonTextColor = calculateColor('#FFFF6F', '#170034');
  static Color simpleTextColor = calculateColor('#FFFFFF', '#3F525D');

  // Estilos de texto
  static TextStyle defaultTextStyle =
      TextStyle(fontSize: 16.0, color: Colors.black87);
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
