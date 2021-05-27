import 'package:campus_share/store/categories.dart';
import 'package:flutter/material.dart';

class CategoriesScrollList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(5),
            width: 110.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                catIcons[index],
                SizedBox(height: 5),
                Text(
                  categories[index].toUpperCase(),
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
