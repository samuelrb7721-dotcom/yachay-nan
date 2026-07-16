import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 26, 20, 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 22),
                  _buildLevelCard(context),
                  const SizedBox(height: 24),
                  Text(
                    'Insignias obtenidas',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 14),
                  const _RewardCard(
                    title: 'Explorador de Ica',
                    description:
                        'Completaste una lección sobre la cultura de Ica.',
                    icon: Icons.explore_rounded,
                    unlocked: true,
                    progressText: 'Completado',
                  ),
                  const SizedBox(height: 14),
                  const _RewardCard(
                    title: 'Gastrónomo',
                    description:
                        'Aprendiste sobre uno de los dulces más representativos del Perú.',
                    icon: Icons.restaurant_rounded,
                    unlocked: true,
                    progressText: 'Completado',
                  ),
                  const SizedBox(height: 14),
                  const _RewardCard(
                    title: 'Maestro de la Sierra',
                    description: 'Completa tres lecciones de la región Sierra.',
                    icon: Icons.landscape_rounded,
                    unlocked: false,
                    progressText: '1 de 3 lecciones',
                  ),
                  const SizedBox(height: 14),
                  const _RewardCard(
                    title: 'Protector de la Amazonía',
                    description:
                        'Completa una lección sobre flora o fauna de la Selva.',
                    icon: Icons.forest_rounded,
                    unlocked: false,
                    progressText: 'Bloqueado',
                  ),
                  const SizedBox(height: 14),
                  const _RewardCard(
                    title: 'Maestro del Perú',
                    description: 'Completa contenido de Costa, Sierra y Selva.',
                    icon: Icons.workspace_premium_rounded,
                    unlocked: false,
                    progressText: '1 de 3 regiones',
                  ),
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
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(
            Icons.emoji_events_rounded,
            color: AppColors.primary,
            size: 34,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mis premios',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Desbloquea logros mientras recorres el Perú.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLevelCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF7D6), Color(0xFFFFFFFF)],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFFFD978)),
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
          Row(
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Color(0xFFFFB01F),
                  size: 44,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nivel 3',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Explorador del Perú',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '680 XP',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: 0.68,
              minHeight: 12,
              backgroundColor: Color(0xFFFFEFC1),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFB01F)),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '680 de 1000 XP',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              Text(
                'Faltan 320 XP',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  const _RewardCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.unlocked,
    required this.progressText,
  });

  final String title;
  final String description;
  final IconData icon;
  final bool unlocked;
  final String progressText;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = unlocked
        ? AppColors.primary
        : AppColors.textSecondary;

    final Color iconBackground = unlocked
        ? AppColors.primaryLight
        : const Color(0xFFE9EFED);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: unlocked
              ? AppColors.primary.withValues(alpha: 0.35)
              : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              unlocked ? icon : Icons.lock_rounded,
              color: iconColor,
              size: 34,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: unlocked
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 9),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: unlocked
                        ? AppColors.primaryLight
                        : const Color(0xFFF1F4F3),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    progressText,
                    style: TextStyle(
                      color: unlocked
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (unlocked)
            const Icon(
              Icons.check_circle_rounded,
              color: AppColors.primary,
              size: 25,
            ),
        ],
      ),
    );
  }
}
