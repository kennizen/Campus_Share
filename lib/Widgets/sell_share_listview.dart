import 'package:flutter/material.dart';

class SellShareListView extends StatelessWidget {
  final Function nav;
  final String appBarTitle;

  SellShareListView(this.nav, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Electronics'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => nav('Electronics', context),
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Books'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => nav('Books', context),
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Instruments'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => nav('Instruments', context),
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Cycles'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => nav('Cycles', context),
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Others'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => nav('Others', context),
          ),
        ],
      ),
    );
  }
}
