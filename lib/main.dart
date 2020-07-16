import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorHomePage(title: 'Flutter Calculator'),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  CalculatorHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  final buttonStyle = TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
  final screenStyle = TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold);

  String output = "0";
  String operator = "";

  double first = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Container(
            child: new Column(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.all(24),
                alignment: Alignment.centerRight,
                child: new Text(output, style: screenStyle)),
            new Expanded(
              child: new Divider(),
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildNumberButton("7"),
                    buildNumberButton("8"),
                    buildNumberButton("9"),
                    buildOperatorButton("*"),
                  ],
                ),
                Row(
                  children: [
                    buildNumberButton("4"),
                    buildNumberButton("5"),
                    buildNumberButton("6"),
                    buildOperatorButton("/"),
                  ],
                ),
                Row(
                  children: [
                    buildNumberButton("1"),
                    buildNumberButton("2"),
                    buildNumberButton("3"),
                    buildOperatorButton("-"),
                  ],
                ),
                Row(
                  children: [
                    buildDecimalButton(),
                    buildNumberButton("0"),
                    buildNumberButton("00"),
                    buildOperatorButton("+"),
                  ],
                ),
                Row(
                  children: [
                    buildClearButton(),
                    buildEqualButton(),
                  ],
                ),
              ],
            )
          ],
        )));
  }

  buttonPressed(String text) {
    String _output = output == "0" ? text : output + text;
    setState(() {
      output = _output;
    });
  }

  operatorPressed(String operator) {
    first = double.parse(output);
    this.operator = operator;
    setState(() {
      output = "0";
    });
  }

  clearPressed() {
    first = 0.0;
    operator = "";
    setState(() {
      output = "0";
    });
  }

  double calculate(String operator, double first, double second) {
    if (operator == "+") {
      return first + second;
    }
    if (operator == "-") {
      return first - second;
    }
    if (operator == "*") {
      return first * second;
    }
    return first / second;
  }

  equalPressed() {
    double second = double.parse(output);
    String result = calculate(this.operator, first, second).toString();
    setState(() {
      output = result;
    });
  }

  decimalPressed() {
    if (!output.contains('.')) {
      setState(() {
        output += '.';
      });
    }
  }

  Expanded buildNumberButton(String text) {
    return new Expanded(
      child: new OutlineButton(
        padding: EdgeInsets.all(24),
        onPressed: () => buttonPressed(text),
        child: new Text(text, style: buttonStyle),
      ),
    );
  }

  Expanded buildOperatorButton(String text) {
    return new Expanded(
      child: new OutlineButton(
        padding: EdgeInsets.all(24),
        onPressed: () => operatorPressed(text),
        child: new Text(text, style: buttonStyle),
      ),
    );
  }

  Expanded buildClearButton() {
    return new Expanded(
      child: new OutlineButton(
        padding: EdgeInsets.all(24),
        onPressed: () => clearPressed(),
        child: new Text("C", style: buttonStyle),
      ),
    );
  }

  Expanded buildEqualButton() {
    return new Expanded(
      child: new OutlineButton(
        padding: EdgeInsets.all(24),
        onPressed: equalPressed,
        child: new Text("=", style: buttonStyle),
      ),
    );
  }

  Expanded buildDecimalButton() {
    return new Expanded(
      child: new OutlineButton(
        padding: EdgeInsets.all(24),
        onPressed: decimalPressed,
        child: new Text(".", style: buttonStyle),
      ),
    );
  }
}
