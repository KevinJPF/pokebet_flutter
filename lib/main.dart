import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokebet_login/global.dart';
import 'package:pokebet_login/views/login_view.dart';

main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  Size designSize = const Size(375, 812);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: ScreenUtilInit(
        designSize: designSize,
        child: Scaffold(
          body: LoginView())
        ),
    );
  }
}
