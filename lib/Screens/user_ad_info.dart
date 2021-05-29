import 'package:campus_share/Screens/update_sell.dart';
import 'package:campus_share/Screens/update_share.dart';
import 'package:campus_share/providers/ad_provider.dart';
import 'package:campus_share/services/database_services.dart';
import 'package:campus_share/services/share_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserAdInfo extends StatefulWidget {
  final String adid;
  final Function manualReset;

  UserAdInfo(this.adid, this.manualReset);

  @override
  _UserAdInfoState createState() => _UserAdInfoState();
}

class _UserAdInfoState extends State<UserAdInfo> {
  final screenWidth = double.infinity;

  void navigateAccToPrice(double price, BuildContext context) {
    if (price == 0) {
      print('update Share');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => UpdateShare(widget.adid, widget.manualReset)));
    } else {
      print('update Sell');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => UpdateSell(widget.adid, widget.manualReset)));
    }
  }

  Future<void> _showAlert() async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Ad'),
        content: Text(
          'Are you sure you want to delete this Ad permanently?',
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Yes'),
            onPressed: () async {
              await DatabaseService().deleteAd(widget.adid);
              widget.manualReset();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('No'),
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
    final ads = Provider.of<Advertisements>(context, listen: false).userAds;
    final id = ads.firstWhere((ad) => ad.adid == widget.adid);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
              onPressed: () async {
                await _showAlert();
              },
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
              Stack(
                alignment: Alignment.bottomCenter,
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
                              Icon(Icons.location_on_outlined),
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
                          style: Theme.of(context).textTheme.headline1,
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
                          'Category:',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CONTACT INFORMATION',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 20),
                    Text(
                      id.contactinfo,
                      style: Theme.of(context).textTheme.headline3,
                    ),
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
