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
                  top: screenSize.height * 0.035,
                  left: 55,
                  right: 55,
                  child: Image.asset(
                    'assets/images/splash/yachay_nan_logo.png',
                    height: 420,
                    fit: BoxFit.contain,
                  ),
                ),

                Positioned(
                  top: screenSize.height * 0.29,
                  left: 24,
                  right: 24,
                  child: const Text(
                    'Explora. Aprende.\nConecta con tus raíces.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF173E3A),
                      fontSize: 30,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 1,
                  child: Image.asset(
                    'assets/images/splash/splash_cat_walking.png',
                    height: 1100,
                    fit: BoxFit.contain,
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
