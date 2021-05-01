import 'package:flutter/material.dart';

class Questions extends StatelessWidget {
  final String questions;

  Questions(this.questions);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50),
      width: double.infinity,
      child: Text(
        questions,
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
