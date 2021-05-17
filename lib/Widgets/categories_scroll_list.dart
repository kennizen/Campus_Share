import 'package:flutter/material.dart';

class CategoriesScrollList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(5),
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.monitor),
                  SizedBox(height: 5),
                  Text('Electronics'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(5),
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book_outlined),
                  SizedBox(height: 5),
                  Text('Books'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(5),
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.speaker_group_outlined),
                  SizedBox(height: 5),
                  Text('Instruments'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(5),
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.agriculture),
                  SizedBox(height: 5),
                  Text('Cycles'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(5),
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.devices_other_sharp),
                  SizedBox(height: 5),
                  Text('Others'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
