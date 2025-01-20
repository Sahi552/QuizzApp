import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_game/core/theme/theme.dart';
import 'package:quiz_game/features/view/widgets/button.dart';
import 'package:quiz_game/features/viewmodel/quiz_viewmodel.dart';

class QuestionContainer extends StatelessWidget {
  const QuestionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final quizViewModel = Provider.of<QuizViewModel>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quizViewModel.currentQuestion?.description ?? '',
            style: AppTheme.qnsStyle,
          ),
          const SizedBox(height: 20),
          ...quizViewModel.currentQuestion?.options.map(
                (option) => GestureDetector(
                  onTap: () {
                    quizViewModel.selectOption(option.id);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: quizViewModel.selectedOptionId == option.id
                          ? AppTheme.tileBackground.withValues()
                          : AppTheme.tileBackground,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppTheme.tealDark),
                      boxShadow: [
                        BoxShadow(
                            color: AppTheme.tealDark,
                            spreadRadius: 1,
                            blurRadius: 2)
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        Icon(
                          quizViewModel.selectedOptionId == option.id
                              ? FontAwesomeIcons.circleDot
                              : FontAwesomeIcons.circle,
                          color: AppTheme.blueDark,
                        ),
                        const SizedBox(width: 20),
                        Text(option.description),
                      ],
                    ),
                  ),
                ),
              ) ??
              [],
          const SizedBox(height: 20),
          GestureDetector(
            child: Button(
                buttonText: quizViewModel.isLastQuestion ? "Submit" : "Next"),
            onTap: () {
              if (quizViewModel.selectedOptionId != null) {
                if (quizViewModel.isLastQuestion) {
                  quizViewModel.finishQuiz();
                } else {
                  quizViewModel.nextQuestion();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
