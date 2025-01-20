import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_game/core/theme/theme.dart';
import 'package:quiz_game/features/view/widgets/questioncontainer.dart';
import 'package:quiz_game/features/view/widgets/quizsummary.dart';
import 'package:quiz_game/features/viewmodel/quiz_viewmodel.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final quizViewModel = Provider.of<QuizViewModel>(context);

    return ChangeNotifierProvider(
      create: (_) => QuizViewModel(),
      builder: (context, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              height: height,
              width: width,
              decoration: BoxDecoration(gradient: AppTheme.colorGradient),
              child: Column(
                children: [
                  AppBar(
                    title: Text(
                      "Quiz",
                      style: AppTheme.btnTxt,
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    iconTheme: IconThemeData(color: Colors.white),
                    actions: [
                      Icon(FontAwesomeIcons.book),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<QuizViewModel>(
                    builder: (context, quizViewModel, child) {
                      if (quizViewModel.questions.isEmpty) {
                        return Center(
                            child: CircularProgressIndicator.adaptive());
                      }

                      if (quizViewModel.isQuizFinished) {
                        return QuizSummary();
                      }

                      return QuestionContainer();
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: quizViewModel.isTimeVisible
                            ? Text(
                                "Remaining Time: ${Provider.of<QuizViewModel>(context).remainingTime} sec",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              )
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
