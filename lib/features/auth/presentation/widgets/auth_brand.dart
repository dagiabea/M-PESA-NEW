import 'package:flutter/material.dart';

class AuthBrand extends StatelessWidget {
  const AuthBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/mpesa_logo.png',
      width: 140,
      filterQuality: FilterQuality.high,
    );
  }
}
