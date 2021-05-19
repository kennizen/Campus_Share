import 'package:flutter/material.dart';

class SellInfo extends StatelessWidget {
  final String cat;

  SellInfo(this.cat);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat),
      ),
    );
  }
}
