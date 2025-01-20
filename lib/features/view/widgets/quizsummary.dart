import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/features/view/widgets/button.dart';
import 'package:quiz_game/features/view/widgets/quizcards.dart';
import 'package:quiz_game/features/viewmodel/quiz_viewmodel.dart';

class QuizSummary extends StatelessWidget {
  const QuizSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final quizViewModel = Provider.of<QuizViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Quiz Summary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Expanded(child: SizedBox()),
          Quizcards(),
          Expanded(child: SizedBox()),
          GestureDetector(
            child: Button(buttonText: "Restart Quiz"),
            onTap: () {
              quizViewModel.restartQuiz();
            },
          )
        ],
      ),
    );
  }
}
