import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yachay_nan/features/welcome/presentation/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

final double screenHeight = screenSize.height;

final double logoTop = screenHeight * 0.10;
final double logoHeight = (screenHeight * 0.20).clamp(180.0, 250.0);

final double textTop = screenHeight * 0.30;
final double textSize = (screenHeight * 0.025).clamp(22.0, 30.0);

final double catTop = screenHeight * 0.42;
final double catHeight = (screenHeight * 0.42).clamp(380.0, 540.0);


    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EC),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/splash/splash_background.png',
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
  top: logoTop,
  left: 90,
  right: 90,
  child: SizedBox(
    height: logoHeight,
    child: Image.asset(
      'assets/images/splash/yachay_nan_logo.png',
      fit: BoxFit.contain,
      alignment: Alignment.center,
    ),
  ),
),

                Positioned(
                  top: textTop,
                  left: 24,
                  right: 24,
                  child: Text(
                    'Explora. Aprende.\nConecta con tus raíces.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF173E3A),
                      fontSize: textSize,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Positioned(
                top: catTop,
  left: 20,
  right: 20,
  child: IgnorePointer(
    child: SizedBox(
      height: catHeight,
      child: Image.asset(
        'assets/images/splash/splash_cat_walking.png',
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
      ),
    ),
  ),
),

                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 1,
                  child: Image.asset(
                    'assets/images/splash/andean_bottom_pattern.png',
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
