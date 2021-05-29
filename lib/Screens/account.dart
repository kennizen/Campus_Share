import 'package:campus_share/Widgets/avatar_selector.dart';
import 'package:campus_share/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Account extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Profile', style: Theme.of(context).textTheme.headline2),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(snapshot.data['pImage']),
                        ElevatedButton(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 30,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            primary: Colors.blueGrey[900],
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => AvatarSelector(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            snapshot.data['username'],
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Text(
                          snapshot.data['email'],
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Joining date: ${DateFormat.yMd().format(DateTime.parse(snapshot.data['joinDate']))}',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey[900],
                        ),
                        onPressed: () async {
                          await _auth.signOutOfApp();
                        },
                        child: Text(
                          'LOGOUT',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
