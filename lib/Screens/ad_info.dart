import 'package:campus_share/providers/ad_provider.dart';
import 'package:campus_share/services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../services/share_price.dart';

class AdInfo extends StatefulWidget {
  final String adid;

  AdInfo(this.adid);

  @override
  _AdInfoState createState() => _AdInfoState();
}

class _AdInfoState extends State<AdInfo> {
  final screenWidth = double.infinity;

  Future<void> _showAlert(context) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Report Ad'),
        content: Text(
          'Are you sure you want to report this Ad?',
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Yes',
            ),
            onPressed: () async {
              final snackBar = SnackBar(
                backgroundColor: Colors.blueGrey[900],
                duration: Duration(seconds: 1),
                content: Text(
                  'Advertisment reported',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.white),
                ),
              );
              await DatabaseService().reportAd(widget.adid);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          TextButton(
            child: Text(
              'No',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ads = Provider.of<Advertisements>(context, listen: false).ads;
    final id = ads.firstWhere((ad) => ad.adid == widget.adid);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blueGrey[900].withOpacity(0.9),
                  Colors.transparent
                ],
              ),
            ),
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 300,
                    width: screenWidth,
                    color: Colors.blueGrey[900],
                    child: Image.network(
                      id.imageUrl,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.blueGrey[900].withOpacity(0.5),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[400],
                      width: 2,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SharePrice(id.price).priceShare(),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        id.title,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 18,
                              ),
                              Container(
                                width: 230,
                                child: Text(
                                  id.location,
                                  style: Theme.of(context).textTheme.headline3,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          DateFormat.yMd().format(id.timestamp),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: screenWidth,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[400],
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'DETAILS',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'CATEGORY:',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(width: 15),
                        Text(
                          id.category,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[400],
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'DESCRIPTION',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 20),
                    Text(
                      id.description,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[400],
                      width: 1,
                    ),
                  ),
                ),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(id.sellerid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'AD BY',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          AssetImage(snapshot.data['pImage']),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data['username'],
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${snapshot.data['email']}',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Member since: ${DateFormat.yMd().format(DateTime.parse(snapshot.data['joinDate']))}',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        );
                      }
                    }),
              ),
              Container(
                width: screenWidth,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[400],
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CONTACT INFORMATION',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 10),
                    Text(
                      id.contactinfo,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey[900],
                    elevation: 0,
                  ),
                  onPressed: () async {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    await _showAlert(context);
                  },
                  child: Text(
                    'REPORT THIS AD',
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
