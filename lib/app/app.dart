import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'package:yachay_nan/features/splash/splash_screen.dart';

class YachayNanApp extends StatelessWidget {
  const YachayNanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yachay Ñan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
