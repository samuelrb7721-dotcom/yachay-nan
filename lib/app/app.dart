import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_theme.dart';
import 'package:yachay_nan/features/splash/presentation/splash_screen.dart';

class YachayNanApp extends StatelessWidget {
  const YachayNanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yachay Ñan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
