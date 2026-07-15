import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';
import 'package:yachay_nan/features/map/domain/models/department.dart';
import 'package:yachay_nan/features/lessons/presentation/screens/lesson_list_screen.dart';
import 'package:yachay_nan/features/gastronomy/presentation/screens/gastronomy_lesson_intro_screen.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({required this.department, super.key});

  final Department department;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                    child: _DepartmentHeader(department: department),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: _DepartmentHeroCard(department: department),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 26, 20, 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.auto_awesome_rounded,
                          color: AppColors.primary,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Explora las categorías',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.auto_awesome_rounded,
                          color: AppColors.primary,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  sliver: SliverGrid(
                    delegate: SliverChildListDelegate([
                      _CategoryCard(
                        title: 'Historia',
                        subtitle: 'Conoce su pasado',
                        icon: Icons.account_balance_rounded,
                        color: const Color(0xFFD99852),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => LessonListScreen(
                                department: department,
                                categoryTitle: 'Historia',
                              ),
                            ),
                          );
                        },
                      ),
                      _CategoryCard(
                        title: 'Gastronomía',
                        subtitle: 'Sabores del Perú',
                        icon: Icons.restaurant_rounded,
                        color: const Color(0xFFF2A93B),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => GastronomyLessonIntroScreen(
                                department: department,
                              ),
                            ),
                          );
                        },
                      ),
                      _CategoryCard(
                        title: 'Flora y fauna',
                        subtitle: 'Naturaleza viva',
                        icon: Icons.eco_rounded,
                        color: const Color(0xFF4BAE6F),
                        onTap: () {
                          _showComingSoon(context, 'Flora y fauna');
                        },
                      ),
                      _CategoryCard(
                        title: 'Tradiciones',
                        subtitle: 'Fiestas y costumbres',
                        icon: Icons.celebration_rounded,
                        color: const Color(0xFFE56F62),
                        onTap: () {
                          _showComingSoon(context, 'Tradiciones');
                        },
                      ),
                      _CategoryCard(
                        title: 'Música',
                        subtitle: 'Ritmos regionales',
                        icon: Icons.music_note_rounded,
                        color: const Color(0xFF9B70C7),
                        onTap: () {
                          _showComingSoon(context, 'Música');
                        },
                      ),
                      _CategoryCard(
                        title: 'Lugares turísticos',
                        subtitle: 'Destinos increíbles',
                        icon: Icons.landscape_rounded,
                        color: const Color(0xFF4A9FD8),
                        onTap: () {
                          _showComingSoon(context, 'Lugares turísticos');
                        },
                      ),
                    ]),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: 0.92,
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

  static void _showComingSoon(BuildContext context, String category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$category de este departamento estará disponible próximamente.',
        ),
      ),
    );
  }
}

class _DepartmentHeader extends StatelessWidget {
  const _DepartmentHeader({required this.department});

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
                department.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 2),
              Text(
                'Descubre la riqueza de este departamento.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DepartmentHeroCard extends StatelessWidget {
  const _DepartmentHeroCard({required this.department});

  final Department department;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE7F8F6), Color(0xFFFFF8EB)],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.border),
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
            right: -4,
            bottom: -8,
            child: Icon(
              _departmentIcon(department.name),
              size: 160,
              color: AppColors.primary.withValues(alpha: 0.13),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowSoft,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  _departmentIcon(department.name),
                  color: AppColors.primary,
                  size: 36,
                ),
              ),
              const Spacer(),
              Text(
                department.name.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.textSecondary,
                    size: 19,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    department.region,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Text(
                    'Progreso ${department.progressPercentage}%',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: department.progress,
                        minHeight: 9,
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.14,
                        ),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  static IconData _departmentIcon(String name) {
    final String normalized = name.trim().toLowerCase();

    if (normalized == 'ica') {
      return Icons.wb_sunny_outlined;
    }

    if (normalized == 'lima' || normalized == 'callao') {
      return Icons.waves_rounded;
    }

    if (normalized == 'cusco') {
      return Icons.temple_buddhist_rounded;
    }

    if (normalized == 'loreto' ||
        normalized == 'ucayali' ||
        normalized == 'san martin') {
      return Icons.forest_rounded;
    }

    return Icons.explore_rounded;
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.34)),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowSoft,
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Icon(icon, color: color, size: 34),
            ),
            const Spacer(),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
