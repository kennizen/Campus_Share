import 'package:campus_share/Screens/sell_share_info.dart';
import 'package:campus_share/Widgets/sell_share_listview.dart';
import 'package:flutter/material.dart';

class Sell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void navigateToSellInfo(String catgry, context) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => SellShareInfo(catgry, 1, null, null),
        ),
      );
    }

    return SellShareListView(navigateToSellInfo, 'What are you selling?');
  }
}
