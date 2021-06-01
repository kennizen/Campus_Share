import 'package:campus_share/Widgets/ad_grid.dart';
import 'package:flutter/material.dart';

class BrowseCatScreen extends StatelessWidget {
  final String cat;

  BrowseCatScreen(this.cat);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(
          color: Colors.blueGrey[900],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          cat,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            AdGrid(cat),
          ],
        ),
      ),
    );
  }
}
