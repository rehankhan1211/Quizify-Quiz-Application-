import 'package:flutter/material.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;

  // Sample questions and options
  final List<Map<String, dynamic>> _questions = [
    {
      "question": " Which protocol is used for email transmission?",
      "options": ["FTP","SMTP","HTTP","SNMP"],
      "answer": 1,
    },
    {
      "question": "What is the time complexity of binary search in the worst case?",
      "options": ["O(n)", "O(log n)", "O(n log n)", "O(n^2)"],
      "answer": 1,
    },
    {
      "question": "In networking, which layer of the OSI model is responsible for routing data?",
      "options": ["Data Link Layer", "Transport Layer", "Network Layer", "Application Layer"],
      "answer": 2,
    },
    {
      "question": "What does HTML stand for?",
      "options": ["Hypertext Markup Language", "Hyperlink and Text Markup Language", "Home Tool Markup Language", "Hyperlink Text Model Language"],
      "answer": 0,
    },
    {
      "question": "Which data structure uses the Last In, First Out (LIFO) principle?",
      "options": ["Queue", "Stack", "Array", "Linked List"],
      "answer": 1,
    },
  ];

  List<int?> _selectedAnswers = List<int?>.filled(5, null);

  void _nextQuestion() {
    if (_selectedAnswers[_currentQuestionIndex] == null) {
      _showAlert("Please select an answer before moving to the next question.");
    } else if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      int score = _calculateScore();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(score: score, totalQuestions: _questions.length),
        ),
      );
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i]["answer"]) {
        score++;
      }
    }
    return score;
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Alert"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${_currentQuestionIndex + 1}/${_questions.length}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              currentQuestion["question"],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Column(
              children: List<Widget>.generate(currentQuestion["options"].length, (index) {
                return ListTile(
                  title: Text(currentQuestion["options"][index]),
                  leading: Radio<int>(
                    value: index,
                    groupValue: _selectedAnswers[_currentQuestionIndex],
                    onChanged: (int? value) {
                      setState(() {
                        _selectedAnswers[_currentQuestionIndex] = value;
                      });
                    },
                  ),
                );
              }),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousQuestion,
                  child: Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: _nextQuestion,
                  child: Text(
                    _currentQuestionIndex == _questions.length - 1 ? "Submit" : "Next",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
