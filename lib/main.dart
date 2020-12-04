import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String equation = "0";
  String result = "0";
  String expression = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else if (buttonText == "+/-") {
        equation = (-1 * double.parse(equation)).toString();
        result = equation;
      } else if (buttonText == "%") {
        equation = (double.parse(equation) / 100).toString();
        result = equation;
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  int mode = 0xffffffff;
  int cTxt = 0xff000000;
  int ac = 0xff7c5cff;
  int splash = 0xff211d36;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Color(mode),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.wb_sunny,
                ),
                iconSize: 40,
                color: Color(0xffFFCC33),
                onPressed: () {
                  setState(() {
                    mode = 0xffffffff;
                    cTxt = 0xff000000;
                    ac = 0xff7c5cff;
                    splash = 0xff211d36;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.brightness_3,
                ),
                iconSize: 40,
                color: Color(0xff7E7C6A),
                onPressed: () {
                  setState(() {
                    mode = 0xff211d36;
                    cTxt = 0xffffffff;
                    ac = 0xff5e47bd;
                    splash = 0xffffffff;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            child: Text(
              result,
              maxLines: 1,
              style: TextStyle(
                fontFamily: "Paul",
                fontSize: 60,
                color: Color(cTxt),
              ),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
          ),
          Container(
            child: Text(
              equation,
              maxLines: 1,
              style: TextStyle(
                fontFamily: "Paul",
                fontSize: 20,
                color: Color(0xff93909f),
              ),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(0, 0, 30, 25),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buttons("AC", null, Color(ac), 22, splash),
              buttons("+/-", null, Color(cTxt), 30, splash),
              buttons("%", null, Color(cTxt), 30, splash),
              buttons("÷", null, Color(cTxt), 33, splash),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buttons("7", null, Color(0xff93909f), 25, splash),
              buttons("8", null, Color(0xff93909f), 25, splash),
              buttons("9", null, Color(0xff93909f), 25, splash),
              buttons("×", null, Color(cTxt), 33, splash),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buttons("4", null, Color(0xff93909f), 25, splash),
              buttons("5", null, Color(0xff93909f), 25, splash),
              buttons("6", null, Color(0xff93909f), 25, splash),
              buttons("-", null, Color(cTxt), 33, splash),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buttons("1", null, Color(0xff93909f), 25, splash),
              buttons("2", null, Color(0xff93909f), 25, splash),
              buttons("3", null, Color(0xff93909f), 25, splash),
              buttons("+", null, Color(cTxt), 33, splash),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buttons("0", null, Color(0xff93909f), 25, splash),
              buttons(".", null, Color(0xff93909f), 40, splash),
              SizedBox(
                width: 95,
              ),
              buttons("=", Color(0xff7c5cff), Color(0xffffffff), 30, splash),
            ],
          ),
        ]),
      ),
    );
  }

  void calc(txt) {}
  Widget buttons(
      String txt, Color color, Color colorFont, double s, int splash) {
    return Container(
        padding: EdgeInsets.all(5),
        child: FlatButton(
          onPressed: () {
            buttonPressed(txt);
          },
          child: Text(
            txt,
            style: TextStyle(fontSize: s, color: colorFont, fontFamily: 'Paul'),
          ),
          color: color,
          splashColor: Color(splash),
          padding: EdgeInsets.all(15),
          shape: CircleBorder(),
        ));
  }
}
