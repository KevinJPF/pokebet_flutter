import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PokeBet/views/login_view.dart';

main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  Size designSize = const Size(375, 812);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: NoTransitionsOnWeb(),
          TargetPlatform.iOS: NoTransitionsOnWeb(),
        }),
      ),
      home: ScreenUtilInit(
          designSize: designSize, child: Scaffold(body: LoginView())),
    );
  }
}

class NoTransitionsOnWeb extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
