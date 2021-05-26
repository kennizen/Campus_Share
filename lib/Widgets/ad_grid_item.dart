import 'package:campus_share/Screens/ad_info.dart';
import 'package:flutter/material.dart';

class AdGridItem extends StatelessWidget {
  final double price;
  final String location;
  final String title;
  final String imageUrl;
  final String adid;

  AdGridItem({
    this.location,
    this.price,
    this.title,
    this.imageUrl,
    this.adid,
  });

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
            builder: (ctx) => AdInfo(adid),
          ),
        );
      },
      child: GridTile(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
        ),
        footer: Container(
          padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(shareSell(price)),
              Text(title),
              Row(
                children: [
                  Icon(Icons.location_pin),
                  Expanded(
                    child: Text(
                      location,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
