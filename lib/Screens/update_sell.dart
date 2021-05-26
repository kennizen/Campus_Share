import 'package:campus_share/Screens/sell_share_info.dart';
import 'package:campus_share/Widgets/sell_share_listview.dart';
import 'package:flutter/material.dart';

class UpdateSell extends StatelessWidget {
  final String adid;
  final Function manualReset;

  UpdateSell(this.adid, this.manualReset);

  @override
  Widget build(BuildContext context) {
    void navigateToSellInfo(String catgry, context) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => SellShareInfo(catgry, 1, adid, manualReset),
        ),
      );
    }

    return SellShareListView(navigateToSellInfo, 'Choose a category');
  }
}
