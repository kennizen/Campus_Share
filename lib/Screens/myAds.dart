import 'package:campus_share/Screens/user_ad_info.dart';
import 'package:campus_share/providers/ad_provider.dart';
import 'package:campus_share/services/auth.dart';
import 'package:campus_share/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MyAds extends StatefulWidget {
  @override
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  void manualReset() {
    setState(() {});
  }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Ads'),
      ),
      body: FutureBuilder(
        future: Provider.of<Advertisements>(context, listen: false)
            .fetchAllAdBasedOnUser(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<Advertisements>(
                builder: (context, value, child) => ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => UserAdInfo(
                            value.userAds[index].adid,
                            manualReset,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                width: 60,
                                height: 60,
                                child: Image.network(
                                  value.userAds[index].imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.userAds[index].title,
                                    style: TextStyle(fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 250,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        value.userAds[index].price == 0
                                            ? Text(
                                                'Sharing',
                                                style: TextStyle(fontSize: 14),
                                              )
                                            : Row(
                                                children: [
                                                  Icon(
                                                    FontAwesome.rupee,
                                                    size: 14,
                                                  ),
                                                  Text(
                                                    value.userAds[index].price
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                        Text(
                                          DateFormat.yMd().format(
                                              value.userAds[index].timestamp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: 70,
                                color: value.userAds[index].markassold
                                    ? Colors.red[200]
                                    : Colors.cyan,
                                child: value.userAds[index].markassold
                                    ? Text('Disabled')
                                    : Text('Active'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (value.userAds[index].markassold) {
                                    await DatabaseService(
                                            uid: _auth.authUser.currentUser.uid)
                                        .markAsSold(
                                            value.userAds[index].adid, false);
                                    setState(() {});
                                  } else {
                                    await DatabaseService(
                                            uid: _auth.authUser.currentUser.uid)
                                        .markAsSold(
                                            value.userAds[index].adid, true);
                                    setState(() {});
                                  }
                                },
                                child: value.userAds[index].markassold
                                    ? Text('Republish')
                                    : Text('Mark as sold'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: value.userAds.length,
                ),
              ),
      ),
    );
  }
}
