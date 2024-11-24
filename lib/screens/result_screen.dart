// lib/screens/result_screen.dart
import 'package:flutter/material.dart';
import '../model/quiz.dart';
import '../model/submission.dart';

class ResultScreen extends StatelessWidget {
  final Submission submission;
  final Quiz quiz;
  final VoidCallback onRestart;

  const ResultScreen({
    super.key,
    required this.submission,
    required this.quiz,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    int correctAnswers = submission.getScore();

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Quiz Finished!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'You Answered $correctAnswers out of ${quiz.questions.length} correctly.',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: quiz.questions.length,
                itemBuilder: (context, index) {
                  final question = quiz.questions[index];
                  final userAnswer = submission.getAnswerFor(question)?.questionAnswer ?? '';
                  final isCorrect = userAnswer == question.goodAnswer;

                  return ListTile(
                    title: Center( // Center the question title
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: isCorrect ? Colors.yellow : Colors.red,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            question.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // Center the answers
                      children: question.possibleAnswers.map((answer) {
                        bool isGoodAnswer = answer == question.goodAnswer;
                        bool isSelected = answer == userAnswer;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center, // Center the row
                          children: [
                            if (isGoodAnswer) 
                              Icon(Icons.check, color: Colors.yellow), // Always show check mark next to good answer
                            Text(
                              answer,
                              style: TextStyle(
                                color: isSelected
                                    ? (isGoodAnswer ? Colors.yellow : Colors.red)
                                    : (isGoodAnswer ? Colors.black : Colors.black),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: onRestart,
              child: const Text("Restart Quiz"),
            ),
          ],
        ),
      ),
    );
  }
}
