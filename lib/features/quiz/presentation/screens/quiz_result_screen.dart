import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';
import 'package:yachay_nan/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:yachay_nan/features/map/domain/models/department.dart';
import 'package:yachay_nan/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:yachay_nan/features/gastronomy/presentation/screens/gastronomy_completion_screen.dart';
import 'package:yachay_nan/core/services/progress_service.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({
    required this.department,
    required this.categoryTitle,
    required this.lessonTitle,
    required this.score,
    required this.totalQuestions,
    super.key,
  });

  final Department department;
  final String categoryTitle;
  final String lessonTitle;
  final int score;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    final double percentage = totalQuestions == 0 ? 0 : score / totalQuestions;

    final bool passed = percentage >= 0.60;
    final int earnedXp = passed ? score * 10 : score * 5;
    final int earnedIntis = passed ? score * 2 : score;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 30),
              child: Column(
                children: [
                  Container(
                    width: 118,
                    height: 118,
                    decoration: BoxDecoration(
                      color: passed
                          ? AppColors.primaryLight
                          : const Color(0xFFFFE9D8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      passed
                          ? Icons.emoji_events_rounded
                          : Icons.refresh_rounded,
                      color: passed
                          ? AppColors.primary
                          : const Color(0xFFE28B3B),
                      size: 66,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    passed ? '¡Desafío superado!' : '¡Sigue practicando!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    passed
                        ? 'Completaste el quiz de $lessonTitle.'
                        : 'Repasa la lección y vuelve a intentarlo.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 26),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: AppColors.border),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadowSoft,
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$score de $totalQuestions respuestas correctas',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 18),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: percentage,
                            minHeight: 12,
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.14,
                            ),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              passed
                                  ? AppColors.primary
                                  : const Color(0xFFE28B3B),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${(percentage * 100).round()}%',
                          style: TextStyle(
                            color: passed
                                ? AppColors.primary
                                : const Color(0xFFE28B3B),
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _RewardCard(
                          icon: Icons.bolt_rounded,
                          value: '+$earnedXp',
                          label: 'Sabiduría',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _RewardCard(
                          icon: Icons.wb_sunny_rounded,
                          value: '+$earnedIntis',
                          label: 'Intis',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: FilledButton(
                      onPressed: () async {
                        if (passed) {
                          if (lessonTitle == 'Teja Iqueña') {
                            await ProgressService.completeTejaIquena();

                            if (!context.mounted) {
                              return;
                            }

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute<void>(
                                builder: (_) =>
                                    const GastronomyCompletionScreen(),
                              ),
                            );
                            return;
                          }

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  const DashboardScreen(initialIndex: 1),
                            ),
                            (Route<dynamic> route) => false,
                          );
                          return;
                        }

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (_) => QuizScreen(
                              department: department,
                              categoryTitle: categoryTitle,
                              lessonTitle: lessonTitle,
                            ),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        passed
                            ? lessonTitle == 'Teja Iqueña'
                                  ? 'Ver recompensas'
                                  : 'Volver al mapa'
                            : 'Intentar nuevamente',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  if (passed) ...[
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Volver a la lección',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  const _RewardCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 31),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
