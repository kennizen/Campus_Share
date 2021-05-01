import 'package:flutter/material.dart';

class HandlerFunctions extends StatelessWidget {
  final Function handle;
  final String ansLabel;

  HandlerFunctions(this.handle, this.ansLabel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: handle,
        child: Text(ansLabel),
      ),
    );
  }
}
