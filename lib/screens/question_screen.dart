import 'package:flutter/material.dart';
import '../model/quiz.dart';
import '../model/submission.dart';
import 'result_screen.dart';

class QuestionScreen extends StatelessWidget {
  final Quiz quiz;
  final VoidCallback onFinish;
  final int currentQuestionIndex;
  final Submission submission;

  const QuestionScreen({
    super.key,
    required this.quiz,
    required this.onFinish,
    required this.currentQuestionIndex,
    required this.submission,
  });

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex < 0 || currentQuestionIndex >= quiz.questions.length) {
      return Center(child: Text("Invalid question index."));
    }

    final currentQuestion = quiz.questions[currentQuestionIndex];

    return Container(
      color: Colors.lightBlue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                currentQuestion.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ...currentQuestion.possibleAnswers.map((answer) {
              return ElevatedButton(
                onPressed: () {
                  submission.addAnswer(currentQuestion, answer);
                  if (currentQuestionIndex < quiz.questions.length - 1) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => QuestionScreen(
                          quiz: quiz,
                          onFinish: onFinish,
                          currentQuestionIndex: currentQuestionIndex + 1,
                          submission: submission,
                        ),
                      ),
                    );
                  } else {
                    onFinish();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          submission: submission,
                          quiz: quiz,
                          onRestart: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => QuestionScreen(
                                  quiz: quiz,
                                  onFinish: onFinish,
                                  currentQuestionIndex: 0,
                                  submission: submission,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
                child: Text(answer),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
