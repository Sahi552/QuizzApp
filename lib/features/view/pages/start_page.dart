import 'package:flutter/material.dart';
import 'package:quiz_game/core/app_assests/assest.dart';
import 'package:quiz_game/core/theme/theme.dart';
import 'package:quiz_game/features/view/pages/quiz_page.dart';
import 'package:quiz_game/features/view/widgets/button.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    //getting device height and width
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      //make scrolalbel
      body: SingleChildScrollView(
        //container for gradient and padding
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(gradient: AppTheme.colorGradient),
          child: Column(
            children: [
              Image.asset(
                Assest.appIcon,
                height: height * 0.40,
                width: width * 0.40,
              ),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        AppTheme.description,
                        style: AppTheme.descript,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20),
                      //clickable
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizPage(),
                              ));
                        },
                        child: Button(
                          buttonText: "Start",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
