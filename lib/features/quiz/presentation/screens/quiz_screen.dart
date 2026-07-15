import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';
import 'package:yachay_nan/features/map/domain/models/department.dart';
import 'package:yachay_nan/features/quiz/presentation/screens/quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    required this.department,
    required this.categoryTitle,
    required this.lessonTitle,
    super.key,
  });

  final Department department;
  final String categoryTitle;
  final String lessonTitle;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<QuizQuestion> _questions;

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _answerWasChecked = false;
  bool _quizFinished = false;

  @override
  void initState() {
    super.initState();
    _questions = _buildQuestions();
  }

  QuizQuestion get _currentQuestion => _questions[_currentQuestionIndex];

  double get _progress => (_currentQuestionIndex + 1) / _questions.length;

  @override
  Widget build(BuildContext context) {
    if (_quizFinished) {
      return QuizResultScreen(
        department: widget.department,
        categoryTitle: widget.categoryTitle,
        lessonTitle: widget.lessonTitle,
        score: _score,
        totalQuestions: _questions.length,
      );
    }

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
                  _buildHeader(context),

                  const SizedBox(height: 22),

                  _buildProgressCard(context),

                  const SizedBox(height: 20),

                  _buildQuestionCard(context),

                  const SizedBox(height: 18),

                  _buildAnswerOptions(),

                  const SizedBox(height: 24),

                  _buildActionButton(),
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
            icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Desafío',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 2),
              Text(
                widget.lessonTitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.stars_rounded,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                '$_score',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Pregunta ${_currentQuestionIndex + 1}',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                '${_currentQuestionIndex + 1}/${_questions.length}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 9,
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

  Widget _buildQuestionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE8F8F6), Color(0xFFFFF6E8)],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.quiz_rounded,
              color: AppColors.primary,
              size: 38,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            _currentQuestion.question,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOptions() {
    return Column(
      children: List<Widget>.generate(_currentQuestion.answers.length, (
        int index,
      ) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == _currentQuestion.answers.length - 1 ? 0 : 12,
          ),
          child: _AnswerOption(
            label: _currentQuestion.answers[index],
            index: index,
            selectedIndex: _selectedAnswerIndex,
            correctIndex: _currentQuestion.correctAnswerIndex,
            showResult: _answerWasChecked,
            onTap: () {
              if (_answerWasChecked) {
                return;
              }

              setState(() {
                _selectedAnswerIndex = index;
              });
            },
          ),
        );
      }),
    );
  }

  Widget _buildActionButton() {
    final bool canContinue = _selectedAnswerIndex != null || _answerWasChecked;

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: FilledButton(
        onPressed: canContinue ? _handleAction : null,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.border.withValues(alpha: 0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          _answerWasChecked
              ? _currentQuestionIndex == _questions.length - 1
                    ? 'Ver resultado'
                    : 'Siguiente pregunta'
              : 'Comprobar respuesta',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  void _handleAction() {
    if (!_answerWasChecked) {
      final bool isCorrect =
          _selectedAnswerIndex == _currentQuestion.correctAnswerIndex;

      setState(() {
        _answerWasChecked = true;

        if (isCorrect) {
          _score++;
        }
      });

      return;
    }

    if (_currentQuestionIndex == _questions.length - 1) {
      setState(() {
        _quizFinished = true;
      });

      return;
    }

    setState(() {
      _currentQuestionIndex++;
      _selectedAnswerIndex = null;
      _answerWasChecked = false;
    });
  }

  List<QuizQuestion> _buildQuestions() {
    if (widget.lessonTitle == 'Teja Iqueña') {
      return const <QuizQuestion>[
        QuizQuestion(
          question: '¿En qué departamento nació la Teja Iqueña?',
          answers: <String>['Ica', 'Piura', 'Cusco', 'Loreto'],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: '¿Cuál es uno de sus rellenos tradicionales?',
          answers: <String>['Pecanas', 'Pescado', 'Papa', 'Quinua'],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: '¿Qué recuerda la cobertura blanca de la Teja Iqueña?',
          answers: <String>[
            'Las antiguas tejas de los techos',
            'La arena del desierto',
            'Las nubes de la sierra',
            'Las olas del mar',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: '¿Cómo se elabora tradicionalmente la Teja Iqueña?',
          answers: <String>[
            'De forma artesanal',
            'Solo con máquinas industriales',
            'Sin ningún relleno',
            'Con harina de maíz',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: '¿Qué representa este dulce para Ica?',
          answers: <String>[
            'Su tradición repostera',
            'Una bebida medicinal',
            'Un instrumento musical',
            'Una danza regional',
          ],
          correctAnswerIndex: 0,
        ),
      ];
    }
    if (widget.lessonTitle == 'Cultura Paracas') {
      return const <QuizQuestion>[
        QuizQuestion(
          question:
              '¿En qué parte del Perú se desarrolló principalmente la cultura Paracas?',
          answers: <String>[
            'En la costa sur',
            'En la selva norte',
            'En la sierra central',
            'En la costa norte',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              '¿Por cuál de estas expresiones artísticas destacó especialmente la cultura Paracas?',
          answers: <String>[
            'Esculturas de mármol',
            'Textiles finamente elaborados',
            'Castillos de piedra',
            'Pinturas al óleo',
          ],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question:
              '¿En qué departamento actual se desarrolló principalmente la cultura Paracas?',
          answers: <String>['Loreto', 'Piura', 'Ica', 'Puno'],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question:
              '¿Qué conocimientos también fueron importantes para los Paracas?',
          answers: <String>[
            'Medicina',
            'Navegación espacial',
            'Imprenta',
            'Electricidad',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: '¿Qué característica distingue a muchos mantos Paracas?',
          answers: <String>[
            'Colores y figuras complejas',
            'Uso exclusivo del color blanco',
            'Fabricación con metal',
            'Ausencia de diseños',
          ],
          correctAnswerIndex: 0,
        ),
      ];
    }

    if (widget.lessonTitle == 'Cultura Nazca') {
      return const <QuizQuestion>[
        QuizQuestion(
          question: '¿Por qué obra es especialmente conocida la cultura Nazca?',
          answers: <String>[
            'Las Líneas de Nazca',
            'Machu Picchu',
            'Chan Chan',
            'Kuélap',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: '¿Qué característica tuvo la cerámica Nazca?',
          answers: <String>[
            'Fue policroma',
            'Solo usó el color negro',
            'Fue hecha de vidrio',
            'No tuvo decoración',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: '¿Qué sistema desarrollaron para aprovechar mejor el agua?',
          answers: <String>[
            'Acueductos',
            'Molinos de viento',
            'Represas eléctricas',
            'Puertos marítimos',
          ],
          correctAnswerIndex: 0,
        ),
      ];
    }

    return const <QuizQuestion>[
      QuizQuestion(
        question: '¿Completaste la lectura de esta lección?',
        answers: <String>['Sí', 'Todavía no'],
        correctAnswerIndex: 0,
      ),
    ];
  }
}

class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
  });

  final String question;
  final List<String> answers;
  final int correctAnswerIndex;
}

class _AnswerOption extends StatelessWidget {
  const _AnswerOption({
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.correctIndex,
    required this.showResult,
    required this.onTap,
  });

  final String label;
  final int index;
  final int? selectedIndex;
  final int correctIndex;
  final bool showResult;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;
    final bool isCorrect = index == correctIndex;
    final bool isIncorrectSelection = showResult && isSelected && !isCorrect;

    Color borderColor = AppColors.border;
    Color backgroundColor = AppColors.surface;
    IconData? trailingIcon;
    Color? trailingIconColor;

    if (showResult && isCorrect) {
      borderColor = AppColors.primary;
      backgroundColor = AppColors.primaryLight.withValues(alpha: 0.62);
      trailingIcon = Icons.check_circle_rounded;
      trailingIconColor = AppColors.primary;
    } else if (isIncorrectSelection) {
      borderColor = AppColors.error;
      backgroundColor = AppColors.error.withValues(alpha: 0.07);
      trailingIcon = Icons.cancel_rounded;
      trailingIconColor = AppColors.error;
    } else if (isSelected) {
      borderColor = AppColors.primary;
      backgroundColor = AppColors.primaryLight.withValues(alpha: 0.38);
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor,
            width: isSelected || (showResult && isCorrect) ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Text(
                String.fromCharCode(65 + index),
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (trailingIcon != null)
              Icon(trailingIcon, color: trailingIconColor, size: 24),
          ],
        ),
      ),
    );
  }
}
