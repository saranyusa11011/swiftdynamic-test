import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import '../colors.dart';
import '../widget/app_icon.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userInput = '';
  var answer = '';

  // Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: new AppBar(
        //   title: new Text("Calculator"),
        // ), //AppBar
        backgroundColor: Colors.white38,
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
              height: 80,
              width: 1000,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                // borderRadius: const BorderRadius.only(
                //     bottomLeft: Radius.circular(20),
                //     bottomRight: Radius.circular(20))
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 7),
                    child: IconButton(
                      onPressed: () {
                        Navigator.popUntil(context, ModalRoute.withName("/"));
                      },
                      icon: const AppIcon(icon: Icons.arrow_back_ios),
                    ),
                  ),
                  Column(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 0, top: 30),
                        child: Text(
                          "Calculator",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userInput,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(bottom: 1000),
                        // padding: EdgeInsets.all(15),
                        alignment: Alignment.centerRight,
                        child: Text(
                          answer,
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                // width: 200, height: 200,
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      // Clear Button
                      if (index == 0) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput = '';
                              answer = '0';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.blue[50],
                          textColor: Colors.black,
                        );
                      }

                      // +/- button
                      else if (index == 1) {
                        return MyButton(
                          buttonText: buttons[index],
                          color: Colors.blue[50],
                          textColor: Colors.black,
                        );
                      }
                      // % Button
                      else if (index == 2) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.blue[50],
                          textColor: Colors.black,
                        );
                      }
                      // Delete Button
                      else if (index == 3) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.blue[50],
                          textColor: Colors.black,
                        );
                      }
                      // Equal_to Button
                      else if (index == 18) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.orange[700],
                          textColor: Colors.white,
                        );
                      }

                      //  other buttons
                      else {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index])
                              ? Colors.blueAccent
                              : Colors.white,
                          textColor: isOperator(buttons[index])
                              ? Colors.white
                              : Colors.black,
                        );
                      }
                    }), // GridView.builder
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    userInput = answer;
  }
}

class MyButton extends StatelessWidget {
  // declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  //Constructor
  const MyButton(
      {this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(25),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
