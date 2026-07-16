import 'package:flutter/material.dart';
import 'package:yachay_nan/features/diagnostic/presentation/screens/diagnostic_intro_screen.dart';
import 'package:yachay_nan/core/session/demo_session.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isCreatingAccount = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  Future<void> _createDemoAccount() async {
    if (_isCreatingAccount) {
      return;
    }

    setState(() {
      _isCreatingAccount = true;
    });

    DemoSession.setUserName(_nameController.text);

    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cuenta creada correctamente. Bienvenido a Yachay Ñan.'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (!mounted) {
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const DiagnosticIntroScreen()),
      (Route<dynamic> route) => false,
    );
  }

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
                                'assets/images/authentication/login_cat_peeking.png',
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
                          padding: const EdgeInsets.fromLTRB(24, 42, 24, 28),
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
                              const Text(
                                'Crear cuenta',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1F3E3A),
                                  fontSize: 34,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                'Comienza tu camino por la historia del Perú.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF5D6C73),
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 22),

                              _RegisterField(
                                controller: _nameController,
                                hintText: 'Nombre completo',
                                icon: Icons.person_outline_rounded,
                                keyboardType: TextInputType.name,
                              ),

                              const SizedBox(height: 14),

                              const _RegisterField(
                                hintText: 'Correo electrónico',
                                icon: Icons.mail_outline_rounded,
                                keyboardType: TextInputType.emailAddress,
                              ),

                              const SizedBox(height: 14),

                              _RegisterField(
                                hintText: 'Contraseña',
                                icon: Icons.lock_outline_rounded,
                                obscureText: obscurePassword,
                                suffixIcon: obscurePassword
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                onSuffixTap: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                              ),

                              const SizedBox(height: 14),

                              _RegisterField(
                                hintText: 'Confirmar contraseña',
                                icon: Icons.lock_reset_rounded,
                                obscureText: obscureConfirmPassword,
                                suffixIcon: obscureConfirmPassword
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                onSuffixTap: () {
                                  setState(() {
                                    obscureConfirmPassword =
                                        !obscureConfirmPassword;
                                  });
                                },
                              ),

                              const SizedBox(height: 14),

                              DropdownButtonFormField<String>(
                                decoration: _fieldDecoration(
                                  hintText: 'Departamento',
                                  prefixIcon: Icons.location_on_outlined,
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFF5D6C73),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Amazonas',
                                    child: Text('Amazonas'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Arequipa',
                                    child: Text('Arequipa'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Cusco',
                                    child: Text('Cusco'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Ica',
                                    child: Text('Ica'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Lima',
                                    child: Text('Lima'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Piura',
                                    child: Text('Piura'),
                                  ),
                                ],
                                onChanged: (value) {},
                              ),

                              const SizedBox(height: 14),

                              const _RegisterField(
                                hintText: 'Edad',
                                icon: Icons.cake_outlined,
                                keyboardType: TextInputType.number,
                              ),

                              const SizedBox(height: 22),

                              SizedBox(
                                width: double.infinity,
                                height: 58,
                                child: ElevatedButton(
                                  onPressed: _isCreatingAccount
                                      ? null
                                      : _createDemoAccount,
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
                                  child: _isCreatingAccount
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.6,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          'Crear cuenta',
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
                                child: const Text.rich(
                                  TextSpan(
                                    text: '¿Ya tienes cuenta? ',
                                    style: TextStyle(color: Color(0xFF5D6C73)),
                                    children: [
                                      TextSpan(
                                        text: 'Inicia sesión',
                                        style: TextStyle(
                                          color: Color(0xFF2FAAA7),
                                          fontWeight: FontWeight.w700,
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

class _RegisterField extends StatelessWidget {
  const _RegisterField({
    required this.hintText,
    required this.icon,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixTap,
  });

  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: _fieldDecoration(
        hintText: hintText,
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        onSuffixTap: onSuffixTap,
      ),
    );
  }
}

InputDecoration _fieldDecoration({
  required String hintText,
  required IconData prefixIcon,
  IconData? suffixIcon,
  VoidCallback? onSuffixTap,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: Color(0xFF5D6C73), fontSize: 16),
    prefixIcon: Icon(prefixIcon, color: const Color(0xFF2FAAA7), size: 25),
    suffixIcon: suffixIcon == null
        ? null
        : IconButton(
            onPressed: onSuffixTap,
            icon: Icon(suffixIcon, color: const Color(0xFF2FAAA7), size: 24),
          ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color(0xFFD8E5E1)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color(0xFFD8E5E1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color(0xFF2FAAA7), width: 1.6),
    ),
  );
}
