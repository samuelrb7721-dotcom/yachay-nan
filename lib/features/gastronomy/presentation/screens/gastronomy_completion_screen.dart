import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';
import 'package:yachay_nan/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:yachay_nan/features/rewards/presentation/screens/collection_screen.dart';

class GastronomyCompletionScreen extends StatelessWidget {
  const GastronomyCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 30),
              child: Column(
                children: [
                  _buildCelebrationHeader(context),

                  const SizedBox(height: 24),

                  const Text(
                    '¡Excelente trabajo!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Has aprendido sobre la Teja Iqueña.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 24),

                  _buildRewardsCard(context),

                  const SizedBox(height: 18),

                  _buildCollectibleCard(context),

                  const SizedBox(height: 18),

                  _buildProgressCard(context),

                  const SizedBox(height: 24),

                  _buildPrimaryButton(context),

                  const SizedBox(height: 10),

                  _buildSecondaryButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCelebrationHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFF2C6), Color(0xFFFFFAEC)],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFF1DDA0)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowSoft,
            blurRadius: 22,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFC83D),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              '¡LECCIÓN COMPLETADA!',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          const SizedBox(height: 22),

          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.88),
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowSoft,
                  blurRadius: 18,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            child: const Icon(
              Icons.emoji_events_rounded,
              color: Color(0xFFFFB51F),
              size: 92,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Teja Iqueña',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Gastronomía de Ica',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsCard(BuildContext context) {
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
        children: [
          const Text(
            'Tus recompensas',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _RewardItem(
                  icon: Icons.wb_sunny_rounded,
                  value: '+150',
                  label: 'Intis',
                  color: Color(0xFFFFB51F),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _RewardItem(
                  icon: Icons.psychology_rounded,
                  value: '+20',
                  label: 'Sabiduría',
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _RewardItem(
                  icon: Icons.star_rounded,
                  value: '+100',
                  label: 'XP',
                  color: Color(0xFFFFC52E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _RewardItem(
                  icon: Icons.bolt_rounded,
                  value: '+1',
                  label: 'Energía',
                  color: Color(0xFF46B8C7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCollectibleCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF2F8D7), Color(0xFFFFF7D9)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFDCE7B4)),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nuevo coleccionable',
                  style: TextStyle(
                    color: Color(0xFF477D32),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Desbloqueaste la ficha de la Teja Iqueña para tu colección.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 14),
          CircleAvatar(
            radius: 37,
            backgroundColor: Colors.white,
            child: Icon(Icons.cake_rounded, color: Color(0xFFE58C27), size: 42),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          const Text(
            'Tu progreso en Gastronomía',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 17),

          Row(
            children: [
              const Icon(
                Icons.restaurant_menu_rounded,
                color: Color(0xFFE58C27),
                size: 38,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const LinearProgressIndicator(
                    value: 0.40,
                    minHeight: 12,
                    backgroundColor: Color(0xFFE8EEE9),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              const Icon(
                Icons.card_giftcard_rounded,
                color: Color(0xFFFFB51F),
                size: 38,
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Text(
            'Lecciones completadas',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),

          const SizedBox(height: 4),

          const Text(
            '2 de 5',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: FilledButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<void>(
              builder: (_) => const DashboardScreen(initialIndex: 1),
            ),
            (Route<dynamic> route) => false,
          );
        },
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Continuar aprendiendo',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const CollectionScreen()));
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ver mi colección',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            SizedBox(width: 9),
            Icon(Icons.arrow_forward_ios_rounded, size: 17),
          ],
        ),
      ),
    );
  }
}

class _RewardItem extends StatelessWidget {
  const _RewardItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
