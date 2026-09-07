import 'package:flutter/material.dart';
import 'package:safaricom_test/core/theme/app_theme.dart';
import 'package:safaricom_test/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safaricom',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.auth,
      routes: AppRoutes.routes,
    );
  }
}
