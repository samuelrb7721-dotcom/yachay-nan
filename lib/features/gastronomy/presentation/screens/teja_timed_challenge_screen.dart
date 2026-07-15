import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';
import 'package:yachay_nan/features/map/domain/models/department.dart';
import 'package:yachay_nan/features/quiz/presentation/screens/quiz_screen.dart';

class TejaTimedChallengeScreen extends StatefulWidget {
  const TejaTimedChallengeScreen({required this.department, super.key});

  final Department department;

  @override
  State<TejaTimedChallengeScreen> createState() =>
      _TejaTimedChallengeScreenState();
}

class _TejaTimedChallengeScreenState extends State<TejaTimedChallengeScreen> {
  static const int _initialSeconds = 110;

  late final List<_TimedQuestion> _questions;
  Timer? _timer;

  int _secondsRemaining = _initialSeconds;
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;

  bool _answerChecked = false;
  bool _challengeFinished = false;
  bool _timeExpired = false;

  @override
  void initState() {
    super.initState();

    _questions = const <_TimedQuestion>[
      _TimedQuestion(
        question: '¿En qué departamento nació la Teja Iqueña?',
        answers: <String>['Ica', 'Cusco', 'Piura', 'Loreto'],
        correctAnswerIndex: 0,
      ),
      _TimedQuestion(
        question: '¿Cuál es uno de sus rellenos tradicionales?',
        answers: <String>['Pecanas', 'Pescado', 'Arroz', 'Papa'],
        correctAnswerIndex: 0,
      ),
      _TimedQuestion(
        question: '¿De qué color es su cobertura tradicional?',
        answers: <String>['Blanca', 'Verde', 'Roja', 'Azul'],
        correctAnswerIndex: 0,
      ),
      _TimedQuestion(
        question: '¿Cómo se prepara tradicionalmente?',
        answers: <String>[
          'De forma artesanal',
          'Solo con maquinaria',
          'Sin relleno',
          'Mediante fritura',
        ],
        correctAnswerIndex: 0,
      ),
      _TimedQuestion(
        question: '¿Qué representa para Ica?',
        answers: <String>[
          'Su tradición repostera',
          'Una danza',
          'Un instrumento',
          'Una bebida',
        ],
        correctAnswerIndex: 0,
      ),
    ];

    _startTimer();
  }

  _TimedQuestion get _currentQuestion => _questions[_currentQuestionIndex];

  double get _progress => (_currentQuestionIndex + 1) / _questions.length;

  String get _formattedTime {
    final int minutes = _secondsRemaining ~/ 60;
    final int seconds = _secondsRemaining % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_secondsRemaining <= 1) {
        timer.cancel();

        setState(() {
          _secondsRemaining = 0;
          _timeExpired = true;
          _challengeFinished = true;
        });

        return;
      }

      setState(() {
        _secondsRemaining--;
      });
    });
  }

  void _checkAnswer() {
    if (_selectedAnswerIndex == null || _answerChecked) {
      return;
    }

    final bool isCorrect =
        _selectedAnswerIndex == _currentQuestion.correctAnswerIndex;

    setState(() {
      _answerChecked = true;

      if (isCorrect) {
        _score += 10;
      }
    });
  }

  void _goNext() {
    if (!_answerChecked) {
      _checkAnswer();
      return;
    }

    if (_currentQuestionIndex == _questions.length - 1) {
      _finishChallenge();
      return;
    }

    setState(() {
      _currentQuestionIndex++;
      _selectedAnswerIndex = null;
      _answerChecked = false;
    });
  }

  void _finishChallenge() {
    _timer?.cancel();

    setState(() {
      _challengeFinished = true;
    });
  }

  void _continueToQuiz() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => QuizScreen(
          department: widget.department,
          categoryTitle: 'Gastronomía',
          lessonTitle: 'Teja Iqueña',
        ),
      ),
    );
  }

  void _restartChallenge() {
    _timer?.cancel();

    setState(() {
      _secondsRemaining = _initialSeconds;
      _currentQuestionIndex = 0;
      _score = 0;
      _selectedAnswerIndex = null;
      _answerChecked = false;
      _challengeFinished = false;
      _timeExpired = false;
    });

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_challengeFinished) {
      return _buildResultScreen(context);
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

                  const SizedBox(height: 20),

                  _buildTimerCard(),

                  const SizedBox(height: 18),

                  _buildProgressCard(),

                  const SizedBox(height: 18),

                  _buildQuestionCard(),

                  const SizedBox(height: 16),

                  _buildAnswers(),

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
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reto contrarreloj',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Teja Iqueña',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            '$_score pts',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimerCard() {
    final bool warning = _secondsRemaining <= 30;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: warning ? const Color(0xFFFFECE8) : AppColors.primaryLight,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: warning
              ? const Color(0xFFE87062)
              : AppColors.primary.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timer_rounded,
            color: warning ? const Color(0xFFE87062) : AppColors.primary,
            size: 34,
          ),
          const SizedBox(width: 12),
          Text(
            _formattedTime,
            style: TextStyle(
              color: warning ? const Color(0xFFE87062) : AppColors.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
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
          const SizedBox(height: 11),
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

  Widget _buildQuestionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE8F8F6), Color(0xFFFFF3DE)],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          const Icon(Icons.speed_rounded, color: AppColors.primary, size: 48),
          const SizedBox(height: 16),
          Text(
            _currentQuestion.question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 21,
              height: 1.35,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswers() {
    return Column(
      children: List<Widget>.generate(_currentQuestion.answers.length, (
        int index,
      ) {
        final bool selected = _selectedAnswerIndex == index;
        final bool correct = index == _currentQuestion.correctAnswerIndex;

        Color backgroundColor = AppColors.surface;
        Color borderColor = AppColors.border;
        IconData? trailingIcon;
        Color? trailingColor;

        if (_answerChecked && correct) {
          backgroundColor = AppColors.primaryLight.withValues(alpha: 0.65);
          borderColor = AppColors.primary;
          trailingIcon = Icons.check_circle_rounded;
          trailingColor = AppColors.primary;
        } else if (_answerChecked && selected && !correct) {
          backgroundColor = const Color(0xFFFFECE8);
          borderColor = const Color(0xFFE87062);
          trailingIcon = Icons.cancel_rounded;
          trailingColor = const Color(0xFFE87062);
        } else if (selected) {
          backgroundColor = AppColors.primaryLight.withValues(alpha: 0.45);
          borderColor = AppColors.primary;
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 11),
          child: InkWell(
            onTap: _answerChecked
                ? null
                : () {
                    setState(() {
                      _selectedAnswerIndex = index;
                    });
                  },
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: borderColor,
                  width: selected || correct && _answerChecked ? 1.8 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        color: selected ? Colors.white : AppColors.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Text(
                      _currentQuestion.answers[index],
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (trailingIcon != null)
                    Icon(trailingIcon, color: trailingColor),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: FilledButton(
        onPressed: _selectedAnswerIndex == null ? null : _goNext,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.border.withValues(alpha: 0.75),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          _answerChecked
              ? _currentQuestionIndex == _questions.length - 1
                    ? 'Finalizar reto'
                    : 'Siguiente'
              : 'Comprobar',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  Widget _buildResultScreen(BuildContext context) {
    final bool completedAll =
        _currentQuestionIndex == _questions.length - 1 && !_timeExpired;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 36, 20, 30),
              child: Column(
                children: [
                  Container(
                    width: 118,
                    height: 118,
                    decoration: BoxDecoration(
                      color: completedAll
                          ? AppColors.primaryLight
                          : const Color(0xFFFFECE8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      completedAll
                          ? Icons.timer_rounded
                          : Icons.hourglass_empty_rounded,
                      color: completedAll
                          ? AppColors.primary
                          : const Color(0xFFE87062),
                      size: 66,
                    ),
                  ),

                  const SizedBox(height: 22),

                  Text(
                    completedAll ? '¡Reto completado!' : '¡Tiempo terminado!',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 29,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    completedAll
                        ? 'Superaste el desafío contrarreloj.'
                        : 'Puedes continuar al quiz o volver a intentarlo.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Puntaje obtenido',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$_score puntos',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Tiempo restante: $_formattedTime',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: FilledButton(
                      onPressed: _continueToQuiz,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Continuar al quiz',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: _restartChallenge,
                    child: const Text(
                      'Volver a intentarlo',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
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

class _TimedQuestion {
  const _TimedQuestion({
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
  });

  final String question;
  final List<String> answers;
  final int correctAnswerIndex;
}
