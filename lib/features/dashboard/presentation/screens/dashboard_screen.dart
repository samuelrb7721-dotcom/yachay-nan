import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';
import 'package:yachay_nan/features/map/data/peru_departments_data.dart';
import 'package:yachay_nan/features/map/presentation/screens/map_screen.dart';
import 'package:yachay_nan/features/gastronomy/presentation/screens/gastronomy_lesson_intro_screen.dart';
import 'package:yachay_nan/core/session/demo_session.dart';
import 'package:yachay_nan/features/regions/presentation/screens/region_overview_screen.dart';
import 'package:yachay_nan/features/profile/presentation/screens/profile_screen.dart';
import 'package:yachay_nan/features/rewards/presentation/screens/rewards_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({this.initialIndex = 0, super.key});

  final int initialIndex;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: IndexedStack(
              index: currentIndex,
              children: [
                const _DashboardHome(),
                MapScreen(),
                const RewardsScreen(),
                const ProfileScreen(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        indicatorColor: AppColors.primaryLight,
        backgroundColor: AppColors.surface,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map_rounded, color: AppColors.primary),
            label: 'Mapa',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(
              Icons.emoji_events_rounded,
              color: AppColors.primary,
            ),
            label: 'Premios',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded, color: AppColors.primary),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class _DashboardHome extends StatelessWidget {
  const _DashboardHome();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _DashboardHeader(),

          const SizedBox(height: 24),

          const _ProgressCard(),

          const SizedBox(height: 24),

          Text(
            'Explora Yachay Ñan',
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 14),

          const GridViewSection(),

          const SizedBox(height: 24),

          const _ContinueLearningCard(),
        ],
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 1.5),
          ),
          child: const Icon(
            Icons.person_rounded,
            color: AppColors.primary,
            size: 32,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¡Hola, ${DemoSession.userName}!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Continúa aprendiendo sobre el Perú.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: () {
            final icaDepartment = peruDepartments.firstWhere(
              (department) => department.name == 'Ica',
            );

            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) =>
                    GastronomyLessonIntroScreen(department: icaDepartment),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowSoft,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nivel 3',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Explorador del Perú',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              const Text(
                '68%',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: 0.68,
              minHeight: 12,
              backgroundColor: AppColors.primaryLight,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Te faltan 320 puntos para llegar al siguiente nivel.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class GridViewSection extends StatelessWidget {
  const GridViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 1.15,
      children: [
        _DashboardOptionCard(
          title: 'Mapa del Perú',
          subtitle: 'Explora las regiones',
          icon: Icons.map_rounded,
          color: AppColors.info,
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute<void>(
                builder: (_) => const DashboardScreen(initialIndex: 1),
              ),
            );
          },
        ),
        _DashboardOptionCard(
          title: 'Costa',
          subtitle: 'Descubre su cultura',
          icon: Icons.waves_rounded,
          color: AppColors.coast,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) =>
                    const RegionOverviewScreen(region: PeruRegion.coast),
              ),
            );
          },
        ),
        _DashboardOptionCard(
          title: 'Selva',
          subtitle: 'Explora la Amazonía',
          icon: Icons.forest_rounded,
          color: AppColors.jungle,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) =>
                    const RegionOverviewScreen(region: PeruRegion.jungle),
              ),
            );
          },
        ),

        _DashboardOptionCard(
          title: 'Sierra',
          subtitle: 'Conoce los Andes',
          icon: Icons.landscape_rounded,
          color: AppColors.highlands,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) =>
                    const RegionOverviewScreen(region: PeruRegion.highlands),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _DashboardOptionCard extends StatelessWidget {
  const _DashboardOptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),

      child: Ink(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: color.withValues(alpha: 0.28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 28),
            ),

            const SizedBox(height: 22),

            Text(title, style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: 4),

            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _ContinueLearningCard extends StatelessWidget {
  const _ContinueLearningCard();

  void _openLastLesson(BuildContext context) {
    final icaDepartment = peruDepartments.firstWhere(
      (department) => department.name == 'Ica',
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => GastronomyLessonIntroScreen(department: icaDepartment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => _openLastLesson(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppColors.secondaryLight,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.play_lesson_rounded,
                color: AppColors.secondary,
                size: 30,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Continúa tu última lección',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Teja Iqueña · Gastronomía de Ica',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () => _openLastLesson(context),
              icon: const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
