import 'package:pokebet/database/db_connection.dart';
import 'package:pokebet/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokebet/views/login/login_view.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Size designSize = const Size(375, 812);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: FadeTransitionOnWeb(),
          TargetPlatform.iOS: FadeTransitionOnWeb(),
        }),
      ),
      home: FutureBuilder(
        future: initDatabaseAndAppConfig(),
        builder: (context, snapshot) => ScreenUtilInit(
            designSize: designSize, child: Scaffold(body: LoginView())),
      ),
    );
  }

  Future<void> initDatabaseAndAppConfig() async {
    await DatabaseConnection().openDb();
    await Global().loadAppConfig();
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
