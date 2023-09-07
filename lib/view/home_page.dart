import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mathgame/core/consts.dart';
import 'package:mathgame/core/number_key.dart';
import 'package:mathgame/core/result_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // numberpad narsalari
  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0',
  ];
  Random randNum = Random();
  int numberA = 4;
  int numberB = 2;
  String userAnswer = '';

  void buttonTapped(String button) {
    setState(() {
      // tozalash

      if (button == '=') {
        checkResult();
      } else if (button == 'C') {
        // qatorni tozalaydi
        userAnswer = '';
      } else if (button == 'DEL') {
        // ohirigi belgini o'chiradi
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 3) {
        // faqat 3 ta raqam kiritish imkoni beradi
        userAnswer += button;
      }
    });
  }

  void checkResult() {
    if (numberA + numberB == int.parse(userAnswer)) {
      showDialog(
        context: context,
        builder: ((context) {
          return ResultDialog(
            message: "Topdingiz",
            onTap: goToNextQuestion,
            bgColor: Colors.deepPurple,
          );
        }),
      );
    } else {
      showDialog(
        context: context,
        builder: ((context) {
          return ResultDialog(
            message: "Topolmadingiz",
            onTap: goToNextQuestion,
            bgColor: Colors.red,
          );
        }),
      );
    }
  }

  Random randomNumber = Random();

  void goToNextQuestion() {
    // dialogni yopadi
    Navigator.of(context).pop();

    // Javoblarni tozalaydi
    setState(() {
      userAnswer = '';
    });

    // Random raqam oladi

    numberA = randomNumber.nextInt(99);
    numberB = randomNumber.nextInt(99);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: SafeArea(
        child: Column(
          children: [
            //bosh qismi
            Container(
              height: 160,
              color: Colors.deepPurple,
              child: const Center(
                child: Text(
                  "AMALNI BAJAR",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                  ),
                ),
              ),
            ),

            // javoblar va savollar
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$numberA + $numberB = ",
                      style: whiteTextStyle,
                    ),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          userAnswer.toString(),
                          style: whiteTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // numberpad
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return MyButton(
                      child: numberPad[index].toString(),
                      onTap: () => buttonTapped(numberPad[index]),
                    );
                  },
                  itemCount: numberPad.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
