import 'package:campus_share/Screens/user_ad_info.dart';
import 'package:campus_share/providers/ad_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'All advertisments',
          style: Theme.of(context).textTheme.headline2,
        ),
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
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey[400],
                          width: 2,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.userAds[index].title,
                                        style: TextStyle(fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          value.userAds[index].price == 0
                                              ? Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesome.handshake_o,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      'Sharing',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1,
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesome.rupee,
                                                      size: 16,
                                                    ),
                                                    Text(
                                                      value.userAds[index].price
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1,
                                                    ),
                                                  ],
                                                ),
                                          Text(
                                            DateFormat.yMd().format(
                                                value.userAds[index].timestamp),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                ),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: 80,
                                decoration: BoxDecoration(
                                  color: value.userAds[index].markassold
                                      ? Colors.redAccent[100]
                                      : Colors.cyanAccent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  value.userAds[index].markassold
                                      ? 'Disabled'
                                      : 'Active',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: Colors.blueGrey[900],
                                ),
                                onPressed: () async {
                                  if (value.userAds[index].markassold) {
                                    await DatabaseService().markAsSold(
                                        value.userAds[index].adid, false);
                                    setState(() {});
                                  } else {
                                    await DatabaseService().markAsSold(
                                        value.userAds[index].adid, true);
                                    setState(() {});
                                  }
                                },
                                child: Text(
                                  value.userAds[index].markassold
                                      ? 'Republish'
                                      : 'Mark as sold',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(color: Colors.white),
                                ),
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
