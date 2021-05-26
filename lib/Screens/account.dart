// import 'package:campus_share/providers/ad_provider.dart';
import 'package:campus_share/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class Account extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    // final userAds = Provider.of<Advertisements>(context).userAds;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(_auth.authUser.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) => !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(snapshot.data['pImage']),
                        SizedBox(width: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data['username'],
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(snapshot.data['email']),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(height: 30),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Total Ads'),
                    //     SizedBox(width: 50),
                    //     Text(
                    //       userAds.length.toString(),
                    //       style: TextStyle(fontSize: 16),
                    //     ),
                    //   ],
                    // ),
                    ElevatedButton(
                      onPressed: () async {
                        await _auth.signOutOfApp();
                      },
                      child: Text('LOGOUT'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
