import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';
import 'package:yachay_nan/features/gastronomy/presentation/screens/teja_iquena_lesson_screen.dart';
import 'package:yachay_nan/features/map/domain/models/department.dart';

class GastronomyLessonIntroScreen extends StatelessWidget {
  const GastronomyLessonIntroScreen({required this.department, super.key});

  final Department department;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(department: department),

                  const SizedBox(height: 22),

                  const _HeroCard(),

                  const SizedBox(height: 24),

                  Text(
                    'En esta lección aprenderás',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 14),

                  const _LearningTopicsCard(),

                  const SizedBox(height: 18),

                  const _CuriosityCard(),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) =>
                                TejaIquenaLessonScreen(department: department),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 5,
                        shadowColor: AppColors.primary.withValues(alpha: 0.35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Comenzar lección',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_rounded, size: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.department});

  final Department department;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
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
              Text(
                'Gastronomía',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 3),
              Text(
                department.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),

        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFFFEDD5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.restaurant_rounded,
            color: Color(0xFFE58C27),
            size: 27,
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 310,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF1D8), Color(0xFFFFE3B3), Color(0xFFFFF8EC)],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFF2D5AA)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowSoft,
            blurRadius: 22,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -28,
            top: -20,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 150,
              color: Colors.white.withValues(alpha: 0.28),
            ),
          ),

          Positioned(
            left: 22,
            top: 22,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.86),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Lección especial',
                style: TextStyle(
                  color: Color(0xFFE58C27),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),

                Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.88),
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadowSoft,
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.cake_rounded,
                    color: Color(0xFFE58C27),
                    size: 72,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'TEJA IQUEÑA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 31,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 7),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    'Descubre el dulce más emblemático de Ica y la historia que guarda en cada bocado.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LearningTopicsCard extends StatelessWidget {
  const _LearningTopicsCard();

  static const List<_TopicData> _topics = [
    _TopicData(
      icon: Icons.history_edu_rounded,
      title: 'Historia',
      subtitle: 'Conocerás el origen de este dulce tradicional.',
      color: Color(0xFFD99852),
    ),
    _TopicData(
      icon: Icons.shopping_basket_rounded,
      title: 'Ingredientes',
      subtitle: 'Identificarás sus componentes principales.',
      color: Color(0xFFE9A23B),
    ),
    _TopicData(
      icon: Icons.bakery_dining_rounded,
      title: 'Elaboración',
      subtitle: 'Aprenderás cómo se prepara paso a paso.',
      color: Color(0xFFCD7C4E),
    ),
    _TopicData(
      icon: Icons.favorite_rounded,
      title: 'Importancia cultural',
      subtitle: 'Descubrirás por qué representa a Ica.',
      color: Color(0xFFE56F62),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowSoft,
            blurRadius: 18,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: _topics
            .asMap()
            .entries
            .map(
              (entry) => Padding(
                padding: EdgeInsets.only(
                  bottom: entry.key == _topics.length - 1 ? 0 : 14,
                ),
                child: _TopicRow(data: entry.value),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _TopicRow extends StatelessWidget {
  const _TopicRow({required this.data});

  final _TopicData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: data.color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(data.icon, color: data.color, size: 27),
        ),

        const SizedBox(width: 13),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 3),
              Text(
                data.subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),

        const Icon(
          Icons.check_circle_outline_rounded,
          color: AppColors.primary,
          size: 22,
        ),
      ],
    );
  }
}

class _CuriosityCard extends StatelessWidget {
  const _CuriosityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.20)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_rounded, color: AppColors.primary, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Dato curioso: la Teja Iqueña recibe su nombre porque su cobertura blanca recuerda a las antiguas tejas de los techos.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicData {
  const _TopicData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
}
