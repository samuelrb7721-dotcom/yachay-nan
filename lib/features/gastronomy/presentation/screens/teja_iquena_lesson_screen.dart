import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';
import 'package:yachay_nan/features/map/domain/models/department.dart';
import 'package:yachay_nan/features/gastronomy/presentation/screens/teja_timed_challenge_screen.dart';

class TejaIquenaLessonScreen extends StatefulWidget {
  const TejaIquenaLessonScreen({required this.department, super.key});

  final Department department;

  @override
  State<TejaIquenaLessonScreen> createState() => _TejaIquenaLessonScreenState();
}

class _TejaIquenaLessonScreenState extends State<TejaIquenaLessonScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<_LessonPageData> _pages = <_LessonPageData>[
    _LessonPageData(
      title: 'Historia',
      icon: Icons.history_edu_rounded,
      color: Color(0xFFD99852),
      description:
          'La Teja Iqueña nació en Ica durante el siglo XIX. Con el tiempo se convirtió en uno de los dulces más representativos de la región.',
      fact:
          'Su forma curva recuerda a las antiguas tejas utilizadas en los techos coloniales.',
    ),
    _LessonPageData(
      title: 'Ingredientes tradicionales',
      icon: Icons.shopping_basket_rounded,
      color: Color(0xFFE9A23B),
      description:
          'Se prepara principalmente con manjar blanco, pecanas o frutas confitadas y una cobertura blanca de azúcar.',
      fact:
          'Las pecanas son uno de los rellenos más tradicionales de la Teja Iqueña.',
    ),
    _LessonPageData(
      title: 'Proceso de elaboración',
      icon: Icons.bakery_dining_rounded,
      color: Color(0xFFCD7C4E),
      description:
          'Primero se prepara el relleno. Luego se cubre cuidadosamente con una capa blanca de azúcar y se deja secar.',
      fact:
          'Cada teja se elabora de forma artesanal, por eso ninguna queda exactamente igual a otra.',
    ),
    _LessonPageData(
      title: 'Importancia cultural',
      icon: Icons.favorite_rounded,
      color: Color(0xFFE56F62),
      description:
          'La Teja Iqueña representa la tradición repostera de Ica y el trabajo de muchas familias que mantienen viva esta receta.',
      fact:
          'Es uno de los recuerdos gastronómicos más buscados por los visitantes de Ica.',
    ),
  ];

  bool get _isLastPage => _currentPage == _pages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_isLastPage) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) =>
              TejaTimedChallengeScreen(department: widget.department),
        ),
      );
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
    );
  }

  void _goBack() {
    if (_currentPage == 0) {
      Navigator.of(context).pop();
      return;
    }

    _pageController.previousPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                  child: _buildHeader(context),
                ),
                _buildProgress(),
                const SizedBox(height: 10),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return _LessonPage(
                        data: _pages[index],
                        pageNumber: index + 1,
                        totalPages: _pages.length,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 22),
                  child: SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: FilledButton(
                      onPressed: _goNext,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLastPage ? 'Iniciar reto' : 'Siguiente',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
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
                'Teja Iqueña',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Lección ${_currentPage + 1} de ${_pages.length}',
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

  Widget _buildProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: LinearProgressIndicator(
          value: (_currentPage + 1) / _pages.length,
          minHeight: 9,
          backgroundColor: AppColors.primary.withValues(alpha: 0.14),
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }
}

class _LessonPage extends StatelessWidget {
  const _LessonPage({
    required this.data,
    required this.pageNumber,
    required this.totalPages,
  });

  final _LessonPageData data;
  final int pageNumber;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [data.color.withValues(alpha: 0.16), AppColors.surface],
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: data.color.withValues(alpha: 0.35)),
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
                Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    color: data.color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(data.icon, color: data.color, size: 44),
                ),
                const SizedBox(height: 18),
                Text(
                  '$pageNumber. ${data.title}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 17,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.52),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.20),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.lightbulb_rounded,
                  color: AppColors.primary,
                  size: 29,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '¿Sabías que?',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data.fact,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            '$pageNumber de $totalPages',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonPageData {
  const _LessonPageData({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.fact,
  });

  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final String fact;
}
