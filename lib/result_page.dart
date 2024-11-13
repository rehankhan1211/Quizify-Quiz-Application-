import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultPage({required this.score, required this.totalQuestions});

  String getRemark() {
    double percentage = (score / totalQuestions) * 100;
    if (percentage == 100) {
      return "Excellent! You scored a perfect $score/$totalQuestions.";
    } else if (percentage >= 80) {
      return "Great job! You scored $score/$totalQuestions.";
    } else if (percentage >= 50) {
      return "Good effort! You scored $score/$totalQuestions.";
    } else {
      return "Keep trying! You scored $score/$totalQuestions.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Result")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Score: $score/$totalQuestions",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                getRemark(),
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Go Back to Start"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
