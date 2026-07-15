import 'package:flutter/material.dart';

class ResetEmailSentScreen extends StatelessWidget {
  const ResetEmailSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8EC),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/authentication/login_background.png',
                  fit: BoxFit.cover,
                ),
              ),

              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 12, 22, 18),
                  child: Column(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 72),
                        child: SizedBox(
                          height: 300,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Transform.scale(
                              scale: 1.36,
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                'assets/images/authentication/'
                                'login_cat_peeking.png',
                                height: 300,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Transform.translate(
                        offset: const Offset(0, -98),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(34, 46, 34, 30),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.97),
                            borderRadius: BorderRadius.circular(34),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x22000000),
                                blurRadius: 28,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.mark_email_read_rounded,
                                size: 74,
                                color: Color(0xFF2FAAA7),
                              ),

                              const SizedBox(height: 18),

                              const Text(
                                '¡Correo enviado!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1F3E3A),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),

                              const SizedBox(height: 12),

                              const Text(
                                'Te enviamos un enlace para restablecer '
                                'tu contraseña.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF5D6C73),
                                  fontSize: 16,
                                  height: 1.4,
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                'Revisa tu bandeja de entrada y también '
                                'la carpeta de correo no deseado.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF5D6C73),
                                  fontSize: 15,
                                  height: 1.4,
                                ),
                              ),

                              const SizedBox(height: 28),

                              SizedBox(
                                width: double.infinity,
                                height: 58,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                    ).popUntil((route) => route.isFirst);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2FAAA7),
                                    foregroundColor: Colors.white,
                                    elevation: 5,
                                    shadowColor: const Color(
                                      0xFF2FAAA7,
                                    ).withValues(alpha: 0.35),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    'Volver al inicio',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 14),

                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cambiar correo electrónico',
                                  style: TextStyle(
                                    color: Color(0xFF2FAAA7),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: 0.24,
                    child: Image.asset(
                      'assets/images/authentication/'
                      'auth_bottom_pattern.png',
                      height: 120,
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
