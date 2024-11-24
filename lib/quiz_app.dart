//lib/quiz_app.dart
import 'package:flutter/material.dart';
import 'model/quiz.dart';
import 'model/submission.dart';
import 'screens/welcome_screen.dart';
import 'screens/question_screen.dart';
import 'screens/result_screen.dart';

Color appColor = Colors.blue[500] as Color;

enum QuizState { notStarted, started, finished }

class QuizApp extends StatefulWidget {
  const QuizApp(this.quiz, {super.key});

  final Quiz quiz;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  QuizState quizState = QuizState.notStarted;
  final Submission submission = Submission();

  void startQuiz() {
    setState(() {
      quizState = QuizState.started;
    });
  }

  void finishQuiz() {
    setState(() {
      quizState = QuizState.finished;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;

    switch (quizState) {
      case QuizState.notStarted:
        screen = WelcomeScreen(
          onStart: startQuiz,
          quizTitle: widget.quiz.title,
        );
        break;
      case QuizState.started:
        screen = QuestionScreen(
          onFinish: finishQuiz,
          quiz: widget.quiz,
          currentQuestionIndex: 0,
          submission: submission,
        );
        break;
      case QuizState.finished:
        screen = ResultScreen(
          submission: submission,
          quiz: widget.quiz,
          onRestart: () {
            setState(() {
              quizState = QuizState.notStarted;
              submission.removeAnswers();
            });
          },
        );
        break;
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: appColor,
        body: Center(child: screen),
      ),
    );
  }
}
