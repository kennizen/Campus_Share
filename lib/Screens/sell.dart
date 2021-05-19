import 'package:campus_share/Screens/sell_info.dart';
import 'package:flutter/material.dart';

class Sell extends StatelessWidget {
  final String category = '';

  void navigateToSellInfo(catgry, context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => SellInfo(catgry),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("What are you offering?"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Electronics'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => navigateToSellInfo('Electronics', context),
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Books'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => navigateToSellInfo('Books', context),
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Instruments'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => navigateToSellInfo('Instruments', context),
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Cycles'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => navigateToSellInfo('Cycles', context),
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Others'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => navigateToSellInfo('Others', context),
          ),
        ],
      ),
    );
  }
}
