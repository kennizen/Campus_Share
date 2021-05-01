import 'package:flutter/material.dart';

import './question.dart';
import './func.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var questions = [
    "1st question",
    "2nd question",
  ];

  var qi = 0;

  void changeQuestion() {
    setState(() {
      qi += 1;
    });
    print(qi);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Campus Share"),
        ),
        body: Column(
          children: [
            Questions(questions[qi]),
            HandlerFunctions(changeQuestion, "Question 1"),
            HandlerFunctions(changeQuestion, "Answer 2"),
            HandlerFunctions(changeQuestion, "Answer 3"),
          ],
        ),
      ),
    );
  }
}
