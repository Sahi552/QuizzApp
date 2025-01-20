import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_game/core/app_assests/urlconstent.dart';
import 'dart:convert';
import 'dart:async';

import 'package:quiz_game/features/model/data_class.dart';

class QuizViewModel extends ChangeNotifier {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  final Map<int, int?> _selectedOptions =
      {}; // Map to store selected option for each question
  bool _showAnswer = false;
  int _remainingTime = 20;
  Timer? _timer;
  bool _isSubmitted = false; // Variable to track if the quiz is submitted
  bool _isTimeVisible = true;

  QuizViewModel() {
    fetchQuestions();
  }

  List<Question> get questions => _questions;
  Question? get currentQuestion =>
      _questions.isNotEmpty ? _questions[_currentQuestionIndex] : null;
  int get score => _score;
  int? get selectedOptionId => _selectedOptions[_currentQuestionIndex];
  bool get showAnswer => _showAnswer;
  bool get isQuizFinished => _currentQuestionIndex >= _questions.length;
  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;
  int get remainingTime => _remainingTime;
  int get answeredQuestions => _selectedOptions.length;
  bool get isSubmitted => _isSubmitted;
  bool get isTimeVisible => _isTimeVisible;
  
  int get correctAnswers {
    int correctCount = 0;
    for (var entry in _selectedOptions.entries) {
      int questionIndex = entry.key;
      int? optionId = entry.value;
      if (optionId != null &&
          _questions[questionIndex]
              .options
              .any((option) => option.isCorrect && option.id == optionId)) {
        correctCount++;
      }
    }
    return correctCount;
  }

  int get totalMarks => correctAnswers * 4;

  //fetch data from api
  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse(Urlconstent.urlConstant));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> questionsJson = data['questions'];
        _questions =
            questionsJson.map((item) => Question.fromJson(item)).toList();

        for (var question in _questions) {
          if (question.options.where((option) => option.isCorrect).isEmpty) {
            throw Exception('Question ${question.id} has no correct options');
          }
        }
        notifyListeners();
        _startTimer(); // Start the timer after data is fetched
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }

  void selectOption(int optionId) {
    _selectedOptions[_currentQuestionIndex] = optionId;
    notifyListeners();
  }

  void nextQuestion() {
    if (_selectedOptions[_currentQuestionIndex] == null) {
      return; // Do nothing if no option is selected
    }

    _updateScore();
    if (isLastQuestion) {
      finishQuiz();
    } else {
      _moveToNextQuestion();
    }
    notifyListeners();
  }

  void finishQuiz() {
    _isSubmitted = true; // Set submitted state to true
    _isTimeVisible = false;
    _currentQuestionIndex = _questions.length;
    _timer?.cancel();
    notifyListeners();
  }

  void restartQuiz() {
    _isSubmitted = false; // Reset submitted state
    _currentQuestionIndex = 0;
    _score = 0;
    _selectedOptions.clear();
    _remainingTime = 20;
    fetchQuestions(); // Fetch questions again and start the timer
    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        _handleTimeOut();
      }
    });
  }

  void _resetTimer() {
    _remainingTime = 20;
    _timer?.cancel();
    _startTimer();
  }

  void _updateScore() {
    bool isCorrect = currentQuestion!.options
        .firstWhere(
            (option) => option.id == _selectedOptions[_currentQuestionIndex])
        .isCorrect;

    if (isCorrect) {
      _score += 4;
    }
  }

  void _moveToNextQuestion() {
    _currentQuestionIndex++;
    _showAnswer = false;
    _resetTimer();
  }

  void _handleTimeOut() {
    // Mark current question as wrong and move to the next
    _selectedOptions[_currentQuestionIndex] =
        -1; // Dummy value to indicate unanswered
    if (isLastQuestion) {
      finishQuiz();
      _resetAnsweredQuestionsIfAllTimedOut();
    } else {
      _moveToNextQuestion();
    }
    notifyListeners();
  }

  void _resetAnsweredQuestionsIfAllTimedOut() {
    bool allTimedOut =
        _selectedOptions.values.every((optionId) => optionId == -1);
    if (allTimedOut) {
      _selectedOptions.clear(); // Clear all answered questions
      _score = 0; // Reset the score
      notifyListeners();
    }
  }
}
