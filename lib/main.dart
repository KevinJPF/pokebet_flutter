import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PokeBet/views/login/login_view.dart';

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
          TargetPlatform.android: FadeTransitionOnWeb(),
          TargetPlatform.iOS: FadeTransitionOnWeb(),
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

class FadeTransitionOnWeb extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Ajuste a duração do fade conforme necessário
    const fadeDuration = Duration(milliseconds: 150);

    return FadeTransition(
      opacity: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
      ),
      child: child,
    );
  }
}