import 'package:campus_share/Widgets/ad_grid.dart';
import 'package:campus_share/Widgets/categories_scroll_list.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 5, top: 10),
              color: Colors.grey[200],
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Browse Categories',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                  CategoriesScrollList(),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 208,
              child: AdGrid(),
            )
          ],
        ),
      ),
    );
  }
}
