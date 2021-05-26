import 'package:campus_share/Screens/update_sell.dart';
import 'package:campus_share/Screens/update_share.dart';
import 'package:campus_share/providers/ad_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserAdInfo extends StatelessWidget {
  final String adid;
  final screenWidth = double.infinity;

  UserAdInfo(this.adid);

  Widget price(price) {
    if (price == 0) {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text('Sharing'),
      );
    }
    return Row(
      children: [
        Icon(FontAwesome.rupee),
        Text(price.toString()),
      ],
    );
  }

  void navigateAccToPrice(double price, BuildContext context) {
    if (price == 0) {
      print('update Share');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => UpdateShare(adid)));
    } else {
      print('update Sell');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => UpdateSell(adid)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ads = Provider.of<Advertisements>(context, listen: false).ads;
    final id = ads.firstWhere((ad) => ad.adid == adid);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            IconButton(
              splashRadius: 25,
              highlightColor: Colors.transparent,
              onPressed: () {
                navigateAccToPrice(id.price, context);
              },
              icon: Icon(FontAwesome.edit),
            ),
            SizedBox(width: 10),
            IconButton(
              splashRadius: 25,
              highlightColor: Colors.transparent,
              onPressed: () {},
              icon: Icon(FontAwesome.trash),
            ),
          ],
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueGrey[900], Colors.transparent],
              ),
            ),
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: screenWidth,
                color: Colors.grey,
                child: Image.network(
                  id.imageUrl,
                ),
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
                    price(id.price),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(id.title),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.location_pin),
                              Text(id.location),
                            ],
                          ),
                        ),
                        Text(DateFormat.yMd().format(id.timestamp)),
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
                    Text('DETAILS'),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Category:'),
                        SizedBox(width: 15),
                        Text(id.category),
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
                    Text('DESCRIPTION'),
                    SizedBox(height: 20),
                    Text(id.description),
                  ],
                ),
              ),
              Container(
                width: screenWidth,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('CONTACT INFORMATION'),
                    SizedBox(height: 20),
                    Text(id.contactinfo),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
