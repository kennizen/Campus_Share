import 'package:campus_share/Screens/sell_share_info.dart';
import 'package:campus_share/Widgets/sell_share_listview.dart';
import 'package:flutter/material.dart';

class Share extends StatelessWidget {
  void navigateToSellInfo(String catgry, context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => SellShareInfo(catgry, true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SellShareListView(navigateToSellInfo, 'What are you sharing?');
  }
}
