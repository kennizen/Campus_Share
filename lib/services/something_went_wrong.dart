import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Something went wrong!'),
          ),
        ),
      ),
    );
  }
}
