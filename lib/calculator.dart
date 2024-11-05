import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:mobile_development/main.dart';

class CalculatorApp extends StatelessWidget{
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        body: Calculator(),
      ),
    );
  }
}

class Calculator extends StatefulWidget{
  const Calculator({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CalculatorState();
}

class CalculatorState extends State<Calculator>{
  String input = "";
  String result = "0";
  List<String> buttons = [
    'AC',
    'Sqr',
    'Sqrt',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '='
  ];

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Калькулятор'),
          backgroundColor: Colors.blue.shade900,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuApp()),
                );
              },
              child: const Text(
                'Меню',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      backgroundColor: Colors.blue.shade200,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  input,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.blue.shade900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  result,
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          Divider(color: Colors.blue.shade900, thickness: 2),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 12,
                ),
                itemCount: buttons.length,
                itemBuilder: (BuildContext context, int index) {
                  return Button(buttons[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget Button(String text){
    return InkWell(
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.blue.shade900,
          borderRadius: BorderRadius.circular(90),
          boxShadow:[ 
            BoxShadow(
              color: Colors.blue.shade400,
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: const Offset(-3, -3),
            ),
          ]
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  handleButtons(String text){
    if (text == "AC"){
      result = "0";
      input = "";
      return;
    }

    if (text == "C"){
      if (input.isNotEmpty){
        input = input.substring(0, input.length - 1);
        return;
      }
      else {
        return null;
      }
    }

    if (text == "="){
      result = calculate();
      input = result;
      if (input.endsWith(".0")){
        input = input.replaceAll(".0", "");
      }
      if (result.endsWith(".0")){
        result = result.replaceAll(".0", "");
      }
      return;
    }

    if (text == "Sqr"){
      result = sqrCalculate();
      input = result;
      if (input.endsWith(".0")){
        input = input.replaceAll(".0", "");
      }
      if (result.endsWith(".0")){
        result = result.replaceAll(".0", "");
      }
      return;
    }

    if (text == "Sqrt"){
      result = sqrtCalculate();
      input = result;
      if (input.endsWith(".0")){
        input = input.replaceAll(".0", "");
      }
      if (result.endsWith(".0")){
        result = result.replaceAll(".0", "");
      }
      return;
    }
    input = input + text;
  }

  String calculate(){
    try {
      var exp = Parser().parse(input);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }
    catch(e){
      return "error";
    }
  }

  String sqrCalculate(){
    try {
      var exp = Parser().parse("$input*$input");
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }
    catch(e){
      return "error";
    }
  }

  String sqrtCalculate(){
    try {
      var exp = Parser().parse("sqrt($input)");
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }
    catch(e){
      return "error";
    }
  }
}