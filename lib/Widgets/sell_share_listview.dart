import 'package:campus_share/store/categories.dart';
import 'package:flutter/material.dart';

class SellShareListView extends StatelessWidget {
  final Function nav;
  final String appBarTitle;

  SellShareListView(this.nav, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.blueGrey[900], //change your color here
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            appBarTitle,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) => ListTile(
            leading: catIcons[index],
            title: Text(categories[index]),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => nav(categories[index], context),
          ),
        ),
      ),
    );
  }
}
