import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';
import 'package:yachay_nan/features/dashboard/presentation/screens/dashboard_screen.dart';

class DiagnosticQuizScreen extends StatefulWidget {
  const DiagnosticQuizScreen({super.key});

  @override
  State<DiagnosticQuizScreen> createState() => _DiagnosticQuizScreenState();
}

class _DiagnosticQuizScreenState extends State<DiagnosticQuizScreen> {
  int _currentStep = 0;

  String? _selectedAge;
  String? _selectedKnowledge;
  String? _selectedRegion;

  final Set<String> _selectedInterests = <String>{};

  static const List<String> _ages = <String>['12–14', '15–17', '18+'];

  static const List<String> _knowledgeLevels = <String>[
    'Estoy comenzando',
    'Conozco algunas cosas',
    'Sé bastante',
  ];

  static const List<String> _regions = <String>['Costa', 'Sierra', 'Selva'];

  static const List<_InterestOption> _interests = <_InterestOption>[
    _InterestOption('Literatura', Icons.menu_book_rounded),
    _InterestOption('Arquitectura', Icons.account_balance_rounded),
    _InterestOption('Historia', Icons.museum_rounded),
    _InterestOption('Gastronomía', Icons.restaurant_rounded),
    _InterestOption('Flora y fauna', Icons.eco_rounded),
    _InterestOption('Música', Icons.music_note_rounded),
    _InterestOption('Danzas', Icons.emoji_people_rounded),
    _InterestOption('Lugares turísticos', Icons.photo_camera_rounded),
  ];

  bool get _canContinue {
    switch (_currentStep) {
      case 0:
        return _selectedAge != null;
      case 1:
        return _selectedKnowledge != null;
      case 2:
        return _selectedRegion != null;
      case 3:
        return _selectedInterests.length >= 2 && _selectedInterests.length <= 3;
      default:
        return false;
    }
  }

  void _goNext() {
    if (!_canContinue) {
      return;
    }

    if (_currentStep == 3) {
      setState(() {
        _currentStep = 4;
      });

      Timer(const Duration(seconds: 2), () {
        if (!mounted) {
          return;
        }

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(builder: (_) => const DashboardScreen()),
          (Route<dynamic> route) => false,
        );
      });

      return;
    }

    setState(() {
      _currentStep++;
    });
  }

  void _goBack() {
    if (_currentStep == 0) {
      Navigator.of(context).pop();
      return;
    }

    if (_currentStep == 4) {
      return;
    }

    setState(() {
      _currentStep--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 26),
              child: _currentStep == 4
                  ? _buildLoadingStep(context)
                  : Column(
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: _buildCurrentStep(context),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildContinueButton(),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: IconButton(
            onPressed: _goBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pon a prueba tus conocimientos',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Paso ${_currentStep + 1} de 4',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentStep(BuildContext context) {
    switch (_currentStep) {
      case 0:
        return _buildSingleChoiceStep(
          key: const ValueKey<String>('age'),
          icon: Icons.cake_rounded,
          title: '¿Cuántos años tienes?',
          subtitle: 'Esto nos ayudará a adaptar tu experiencia.',
          options: _ages,
          selectedValue: _selectedAge,
          onSelected: (String value) {
            setState(() {
              _selectedAge = value;
            });
          },
        );
      case 1:
        return _buildSingleChoiceStep(
          key: const ValueKey<String>('knowledge'),
          icon: Icons.psychology_rounded,
          title: '¿Cuánto conoces sobre el Perú?',
          subtitle: 'No hay respuestas incorrectas.',
          options: _knowledgeLevels,
          selectedValue: _selectedKnowledge,
          onSelected: (String value) {
            setState(() {
              _selectedKnowledge = value;
            });
          },
        );
      case 2:
        return _buildSingleChoiceStep(
          key: const ValueKey<String>('region'),
          icon: Icons.public_rounded,
          title: '¿Qué región te interesa más?',
          subtitle: 'Podrás explorar todas más adelante.',
          options: _regions,
          selectedValue: _selectedRegion,
          onSelected: (String value) {
            setState(() {
              _selectedRegion = value;
            });
          },
        );
      case 3:
        return _buildInterestsStep(context);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSingleChoiceStep({
    required Key key,
    required IconData icon,
    required String title,
    required String subtitle,
    required List<String> options,
    required String? selectedValue,
    required ValueChanged<String> onSelected,
  }) {
    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowSoft,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(icon, color: AppColors.primary, size: 40),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          ...options.map((String option) {
            final bool selected = selectedValue == option;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  onSelected(option);
                },
                borderRadius: BorderRadius.circular(20),
                child: Ink(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 17,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primaryLight.withValues(alpha: 0.65)
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected ? AppColors.primary : AppColors.border,
                      width: selected ? 1.8 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selected
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: selected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Text(
                          option,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildInterestsStep(BuildContext context) {
    return Container(
      key: const ValueKey<String>('interests'),
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowSoft,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Personaliza tu viaje por el Perú',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Elige entre 2 y 3 temas para recibir recomendaciones personalizadas.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 22),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _interests.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.15,
            ),
            itemBuilder: (BuildContext context, int index) {
              final _InterestOption interest = _interests[index];
              final bool selected = _selectedInterests.contains(interest.label);

              return InkWell(
                onTap: () {
                  setState(() {
                    if (selected) {
                      _selectedInterests.remove(interest.label);
                      return;
                    }

                    if (_selectedInterests.length < 3) {
                      _selectedInterests.add(interest.label);
                    }
                  });
                },
                borderRadius: BorderRadius.circular(18),
                child: Ink(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: selected ? AppColors.primary : AppColors.border,
                      width: selected ? 1.8 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        interest.icon,
                        color: selected ? Colors.white : AppColors.primary,
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          interest.label,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (selected)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            '${_selectedInterests.length}/3 seleccionados',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: FilledButton(
        onPressed: _canContinue ? _goNext : null,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.border.withValues(alpha: 0.75),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          _currentStep == 3 ? 'Preparar mi ruta' : 'Siguiente',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  Widget _buildLoadingStep(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(42),
          ),
          child: const Icon(
            Icons.explore_rounded,
            color: AppColors.primary,
            size: 82,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Preparando tu ruta...',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 31,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 16),
        const SizedBox(
          width: 280,
          child: LinearProgressIndicator(
            minHeight: 12,
            color: AppColors.primary,
            backgroundColor: AppColors.primaryLight,
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Estamos personalizando tu aventura por el Perú.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
            height: 1.45,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _InterestOption {
  const _InterestOption(this.label, this.icon);

  final String label;
  final IconData icon;
}
