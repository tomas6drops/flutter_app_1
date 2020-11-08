import 'dart:core';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main(){
  runApp(Calculator());

}
class Calculator  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Calculator' ,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}
class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation ="0";
  String result = "0";
  String expression ="";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;


  buttonPressed(String buttonText){
    setState(() {
      if (buttonText == "c") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "#") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        try{
          Parser p = Parser();
          Expression exp =p.parse(expression);

          ContextModel cm =ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }
      } else {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });

  }
  Widget buildButton(String buttonText,double buttonHeight,Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height*0.1*buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Colors.white,
                width: 1,
                style: BorderStyle.solid
            )
        ),
        padding: EdgeInsets.all(16.0),
        onPressed:() => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white
          ),
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('simple Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation,style:TextStyle(fontSize: equationFontSize),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result,style:TextStyle(fontSize: resultFontSize),),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*.75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("c", 1, Colors.lightGreenAccent),
                          buildButton("#", 1, Colors.black87),
                          buildButton("/", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("9", 1, Colors.black38),
                          buildButton("8", 1, Colors.black38),
                          buildButton("7", 1, Colors.black38),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("6", 1, Colors.black38),
                          buildButton("5", 1, Colors.black38),
                          buildButton("4", 1, Colors.black38),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("3", 1, Colors.black38),
                          buildButton("2", 1, Colors.black38),
                          buildButton("1", 1, Colors.black38),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.black38),
                          buildButton("0", 1, Colors.black38),
                          buildButton(",", 1, Colors.black38)
                        ]
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("*", 1, Colors.black38),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.black38),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.black38),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=",2, Colors.red)
                        ]
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

