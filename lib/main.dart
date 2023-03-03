import 'package:calculator/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  var input = "";
  var output = "";
  var operations = "";
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    //Apply logic for some operations
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "<--") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        //userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input += value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text(
                    //   hideInput ? "" : input,
                    //   style: TextStyle(
                    //       fontSize: 54,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    // ),
                    (hideInput ? "" : input)
                        .text
                        .size(54)
                        .bold
                        .color(Colors.white)
                        .make(),
                    SizedBox(
                      height: 20,
                    ),
                    output.text
                        .size(outputSize)
                        .bold
                        .color(Colors.white.withOpacity(0.5))
                        .make(),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ),

            //button area
            Row(
              children: [
                button(
                    text: "AC",
                    bgbuttonColor: operartorColor,
                    tcolor: orangeColor),
                button(
                    text: "<--",
                    bgbuttonColor: operartorColor,
                    tcolor: orangeColor),
                button(text: "", bgbuttonColor: Colors.transparent),
                button(
                  text: "/",
                  bgbuttonColor: operartorColor,
                )
              ],
            ),
            Row(
              children: [
                button(
                  text: "9",
                ),
                button(text: "8"),
                button(text: "7"),
                button(
                  text: "*",
                  bgbuttonColor: operartorColor,
                )
              ],
            ),
            Row(
              children: [
                button(
                  text: "4",
                ),
                button(text: "5"),
                button(text: "6"),
                button(
                  text: "-",
                  bgbuttonColor: operartorColor,
                )
              ],
            ),
            Row(
              children: [
                button(
                  text: "1",
                ),
                button(text: "2"),
                button(text: "3"),
                button(
                  text: "+",
                  bgbuttonColor: operartorColor,
                )
              ],
            ),
            Row(
              children: [
                button(
                    text: "%",
                    bgbuttonColor: operartorColor,
                    tcolor: orangeColor),
                button(text: "0"),
                button(text: "."),
                button(text: "=", bgbuttonColor: orangeColor)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget button(
      {
      //specified clor and text in cal
      text,
      tcolor = Colors.white,
      bgbuttonColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(22),
              primary: bgbuttonColor),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: tcolor),
          ),
        ),
      ),
    );
  }
}
