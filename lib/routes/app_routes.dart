import 'package:flutter/material.dart';
import 'package:safaricom_test/features/auth/presentation/screens/auth_screen.dart';
import 'package:safaricom_test/features/home/presentation/screens/home_screen.dart';
import 'package:safaricom_test/features/splash/presentation/screens/splash_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String auth = '/auth';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    auth: (context) => const AuthScreen(),
    home: (context) => const HomeScreen(),
  };
}
