import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/core/theme/theme.dart';
import 'package:quiz_game/features/viewmodel/quiz_viewmodel.dart';

class Quizcards extends StatelessWidget {
  const Quizcards({super.key});

  @override
  Widget build(BuildContext context) {
    final quizViewModel = Provider.of<QuizViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(        
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CardsContainer(
              cardtoptxt: "Total Question",
              cardbtmtxt: "${quizViewModel.questions.length}",
            ),
            CardsContainer(
              cardtoptxt: "Qns Answered",
              cardbtmtxt: "${quizViewModel.answeredQuestions}",
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CardsContainer(
              cardtoptxt: "Correct Ans",
              cardbtmtxt: "${quizViewModel.correctAnswers}",
            ),
            CardsContainer(
              cardtoptxt: "Marks Gained",
              cardbtmtxt: "${quizViewModel.totalMarks}",
            ),
          ],
        ),
      ],
    );
  }
}

class CardsContainer extends StatelessWidget {
  final String cardtoptxt;
  final String cardbtmtxt;
  const CardsContainer(
      {super.key, required this.cardtoptxt, required this.cardbtmtxt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.blueDark),
          gradient: AppTheme.colorGradient),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              cardtoptxt,
              style: AppTheme.cardtxt,
            ),
            Text(
              cardbtmtxt,
              style: AppTheme.cardans,
            )
          ],
        ),
      ),
    );
  }
}
