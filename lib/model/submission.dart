import 'quiz.dart';

class Answer {
  final String questionAnswer;
  final Question question;

  Answer({required this.questionAnswer, required this.question});

  bool isCorrect() {
    return questionAnswer == question.goodAnswer;
  }
}

class Submission {
  final Map<Question, String> _answers = {};

  void addAnswer(Question question, String answer) {
    _answers[question] = answer;
  }

  void removeAnswers() {
    _answers.clear();
  }

  int getScore() {
    int score = 0;
    for (var entry in _answers.entries) {
      if (entry.value == entry.key.goodAnswer) {
        score++;
      }
    }
    return score;
  }

  Answer? getAnswerFor(Question question) {
    if (_answers.containsKey(question)) {
      return Answer(questionAnswer: _answers[question]!, question: question);
    }
    return null;
  }
}
