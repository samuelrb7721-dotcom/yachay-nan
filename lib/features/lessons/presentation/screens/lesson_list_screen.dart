import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';
import 'package:yachay_nan/features/map/domain/models/department.dart';
import 'package:yachay_nan/features/quiz/presentation/screens/quiz_intro_screen.dart';

class LessonListScreen extends StatelessWidget {
  const LessonListScreen({
    required this.department,
    required this.categoryTitle,
    super.key,
  });

  final Department department;
  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    final List<_LessonItem> lessons = _buildLessons();

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
                    child: _LessonHeader(
                      department: department,
                      categoryTitle: categoryTitle,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                    child: _CategoryProgressCard(
                      department: department,
                      categoryTitle: categoryTitle,
                      completedLessons: 1,
                      totalLessons: lessons.length,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 30),
                  sliver: SliverList.separated(
                    itemCount: lessons.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final _LessonItem lesson = lessons[index];

                      return _LessonCard(
                        lesson: lesson,
                        onTap: () {
                          _openLesson(context, lesson);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<_LessonItem> _buildLessons() {
    if (categoryTitle == 'Historia' && department.name.toLowerCase() == 'ica') {
      return const [
        _LessonItem(
          number: 1,
          title: 'Cultura Paracas',
          subtitle: 'Descubre una de las culturas más antiguas del Perú.',
          icon: Icons.history_edu_rounded,
          status: _LessonStatus.completed,
        ),
        _LessonItem(
          number: 2,
          title: 'Cultura Nazca',
          subtitle: 'Conoce sus líneas, cerámicas y grandes misterios.',
          icon: Icons.auto_awesome_rounded,
          status: _LessonStatus.available,
        ),
        _LessonItem(
          number: 3,
          title: 'La independencia en Ica',
          subtitle: 'Aprende el papel de Ica en la historia republicana.',
          icon: Icons.flag_rounded,
          status: _LessonStatus.locked,
        ),
        _LessonItem(
          number: 4,
          title: 'Personajes históricos',
          subtitle: 'Conoce a quienes marcaron la historia de la región.',
          icon: Icons.groups_rounded,
          status: _LessonStatus.locked,
        ),
      ];
    }

    return const [
      _LessonItem(
        number: 1,
        title: 'Introducción',
        subtitle: 'Conoce los aspectos principales de esta categoría.',
        icon: Icons.menu_book_rounded,
        status: _LessonStatus.available,
      ),
      _LessonItem(
        number: 2,
        title: 'Contenido principal',
        subtitle: 'Profundiza en los temas más importantes.',
        icon: Icons.lightbulb_rounded,
        status: _LessonStatus.locked,
      ),
      _LessonItem(
        number: 3,
        title: 'Desafío final',
        subtitle: 'Pon a prueba todo lo aprendido.',
        icon: Icons.emoji_events_rounded,
        status: _LessonStatus.locked,
      ),
    ];
  }

  void _openLesson(BuildContext context, _LessonItem lesson) {
    if (lesson.status == _LessonStatus.locked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa la lección anterior para desbloquear esta.'),
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => LessonDetailScreen(
          department: department,
          categoryTitle: categoryTitle,
          lessonTitle: lesson.title,
        ),
      ),
    );
  }
}

class _LessonHeader extends StatelessWidget {
  const _LessonHeader({required this.department, required this.categoryTitle});

  final Department department;
  final String categoryTitle;

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
                categoryTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 2),
              Text(
                department.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryProgressCard extends StatelessWidget {
  const _CategoryProgressCard({
    required this.department,
    required this.categoryTitle,
    required this.completedLessons,
    required this.totalLessons,
  });

  final Department department;
  final String categoryTitle;
  final int completedLessons;
  final int totalLessons;

  @override
  Widget build(BuildContext context) {
    final double progress = totalLessons == 0
        ? 0
        : completedLessons / totalLessons;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(26),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: AppColors.primary,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$categoryTitle de ${department.name}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$completedLessons de $totalLessons lecciones completadas',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: AppColors.primary.withValues(alpha: 0.14),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  const _LessonCard({required this.lesson, required this.onTap});

  final _LessonItem lesson;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isLocked = lesson.status == _LessonStatus.locked;
    final bool isCompleted = lesson.status == _LessonStatus.completed;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isCompleted ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: isLocked
                    ? AppColors.border.withValues(alpha: 0.45)
                    : AppColors.primaryLight,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                isLocked ? Icons.lock_rounded : lesson.icon,
                color: isLocked ? AppColors.textMuted : AppColors.primary,
                size: 30,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lección ${lesson.number}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    lesson.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lesson.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              isCompleted
                  ? Icons.check_circle_rounded
                  : isLocked
                  ? Icons.lock_outline_rounded
                  : Icons.arrow_forward_ios_rounded,
              color: isCompleted ? AppColors.primary : AppColors.textMuted,
              size: 21,
            ),
          ],
        ),
      ),
    );
  }
}

enum _LessonStatus { completed, available, locked }

class _LessonItem {
  const _LessonItem({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.status,
  });

  final int number;
  final String title;
  final String subtitle;
  final IconData icon;
  final _LessonStatus status;
}

class LessonDetailScreen extends StatelessWidget {
  const LessonDetailScreen({
    required this.department,
    required this.categoryTitle,
    required this.lessonTitle,
    super.key,
  });

  final Department department;
  final String categoryTitle;
  final String lessonTitle;

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
                  Row(
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
                        child: Text(
                          lessonTitle,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Container(
                    width: double.infinity,
                    height: 240,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE7F8F6), Color(0xFFFFF4E5)],
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: const Icon(
                      Icons.history_edu_rounded,
                      size: 110,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    lessonTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$categoryTitle de ${department.name}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    _lessonContent(),
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 17,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 26),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => QuizIntroScreen(
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
                      child: const Text(
                        'Completar lección',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
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

  String _lessonContent() {
    if (lessonTitle == 'Cultura Paracas') {
      return 'La cultura Paracas se desarrolló en la costa sur del Perú, '
          'principalmente en el actual departamento de Ica. Destacó por sus '
          'textiles finamente elaborados, su conocimiento de la medicina y '
          'sus prácticas funerarias. Sus mantos son reconocidos por la riqueza '
          'de sus colores, figuras y técnicas de tejido.';
    }

    if (lessonTitle == 'Cultura Nazca') {
      return 'La cultura Nazca se desarrolló en los valles del sur del Perú. '
          'Es conocida por las Líneas de Nazca, sus cerámicas policromas y sus '
          'avanzados sistemas de acueductos. Su legado continúa siendo uno de '
          'los grandes símbolos culturales de Ica.';
    }

    return 'En esta lección aprenderás los aspectos más importantes de '
        '$lessonTitle y su relación con el departamento de ${department.name}.';
  }
}
