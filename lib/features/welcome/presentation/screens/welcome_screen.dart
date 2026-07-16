import 'package:flutter/material.dart';
import 'package:yachay_nan/features/authentication/presentation/screens/login_register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    final double screenHeight = screenSize.height;

    final bool isShortScreen = screenHeight < 760;
    final bool isVeryShortScreen = screenHeight < 650;

    final double titleTop = isVeryShortScreen
        ? 42
        : isShortScreen
        ? 58
        : screenHeight * 0.09;

    final double titleFontSize = isVeryShortScreen
        ? 31
        : isShortScreen
        ? 35
        : 40;

    final double dividerTop = isVeryShortScreen
        ? 145
        : isShortScreen
        ? 170
        : screenHeight * 0.235;

    final double descriptionTop = isVeryShortScreen
        ? 185
        : isShortScreen
        ? 220
        : screenHeight * 0.30;

    final double descriptionFontSize = isVeryShortScreen
        ? 17
        : isShortScreen
        ? 19
        : 22;

    final double catHeight = isVeryShortScreen
        ? 300
        : isShortScreen
        ? 390
        : 500;

    final double catBottom = isVeryShortScreen
        ? 88
        : isShortScreen
        ? 95
        : 105;

    final double buttonBottom = isVeryShortScreen
        ? 18
        : isShortScreen
        ? 32
        : 65;

    final double buttonHeight = isVeryShortScreen
        ? 54
        : isShortScreen
        ? 60
        : 68;

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
                // Fondo andino
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/welcome/welcome_background.png',
                    fit: BoxFit.cover,
                  ),
                ),

                // Decoración superior izquierda
                Positioned(
                  top: 8,
                  left: 8,
                  child: Transform.translate(
                    offset: const Offset(-8, -30),
                    child: Transform.scale(
                      scale: 1.25,
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/images/welcome/welcome_top_left.png',
                        width: 135,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                // Decoración superior derecha
                Positioned(
                  top: 8,
                  right: 8,
                  child: Transform.translate(
                    offset: const Offset(8, -30),
                    child: Transform.scale(
                      scale: 1.25,
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/welcome/welcome_top_right.png',
                        width: 135,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                // Título
                Positioned(
                  top: titleTop,
                  left: 30,
                  right: 30,
                  child: Text(
                    '¡Bienvenido a\nYachay Ñan!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF173E3A),
                      fontSize: titleFontSize,
                      height: 1.08,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                Positioned(
                  top: dividerTop,
                  left: 35,
                  right: 35,
                  child: SizedBox(
                    height: 42,
                    child: ClipRect(
                      child: Transform.scale(
                        scale: 3.5,
                        child: Image.asset(
                          'assets/images/welcome/welcome_divider.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),

                // Texto descriptivo
                Positioned(
                  top: descriptionTop,
                  left: 45,
                  right: 45,
                  child: Text(
                    'Aprende, descubre y vive\nla cultura del Perú.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF4A5E67),
                      fontSize: descriptionFontSize,
                      height: 1.45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // Mascota
                Positioned(
                  left: 35,
                  right: 35,
                  bottom: catBottom,
                  child: IgnorePointer(
                    child: SizedBox(
                      height: catHeight,
                      child: Image.asset(
                        'assets/images/welcome/welcome_cat.png',
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),

                // Botón Comenzar
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: buttonBottom,
                  child: SizedBox(
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const LoginRegisterScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF24AAA7),
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Comenzar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 18),
                          Icon(Icons.arrow_forward_rounded, size: 25),
                        ],
                      ),
                    ),
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
