import 'package:campus_share/Screens/ad_info.dart';
import 'package:campus_share/models/advertisement.dart';
import 'package:flutter/material.dart';

class AdGridItem extends StatelessWidget {
  final Advertisement ad;

  AdGridItem(this.ad);

  String shareSell(double price) {
    if (price == null) {
      return 'Sharing';
    }
    return price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => AdInfo(ad),
          ),
        );
      },
      child: GridTile(
        child: Image.network(
          ad.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: Container(
          padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(shareSell(ad.price)),
              Text(ad.title),
              Row(
                children: [
                  Icon(Icons.location_pin),
                  Text(ad.location),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
