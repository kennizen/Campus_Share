import 'package:campus_share/models/advertisement.dart';
import 'package:flutter/material.dart';

class AdInfo extends StatelessWidget {
  final Advertisement ad;
  final screenWidth = double.infinity;

  AdInfo(this.ad);

  Widget price(price) {
    if (price == null) {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text('Sharing'),
      );
    }
    return Row(
      children: [
        Icon(Icons.attach_money),
        Text(price.toString()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  ad.imageUrl,
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
                    price(ad.price),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(ad.title),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.location_pin),
                              Text(ad.location),
                            ],
                          ),
                        ),
                        Text(ad.timestamp.toLocal().toString()),
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
                        Text(ad.category),
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
                    Text(ad.description),
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
                    Text('AD BY'),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(ad.imageUrl),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Seller Name'),
                            SizedBox(height: 5),
                            Text('Member since ${ad.timestamp}')
                          ],
                        )
                      ],
                    )
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
                    Text('CONTACT INFORMATION'),
                    SizedBox(height: 10),
                    Text(ad.contactinfo),
                  ],
                ),
              ),
              Container(
                width: screenWidth,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('AD ID: ${ad.adid}'),
                    TextButton(
                      onPressed: () {},
                      child: Text('REPORT THIS AD'),
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
