import 'package:campus_share/Widgets/ad_grid.dart';
import 'package:campus_share/Widgets/categories_scroll_list.dart';
import 'package:campus_share/providers/ad_provider.dart';
import 'package:campus_share/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<Advertisements>(context, listen: false).fetchAllAd();
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.blueGrey[900],
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(_auth.authUser.currentUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Text('Loading...')
                        : Text(
                            'Welcome ${snapshot.data['username']}',
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(color: Colors.white),
                          );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 5, top: 10),
                color: Theme.of(context).backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Browse by categories',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    CategoriesScrollList(),
                  ],
                ),
              ),
              AdGrid(''),
            ],
          ),
        ),
      ),
    );
  }
}
