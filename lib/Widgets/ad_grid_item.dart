import 'package:campus_share/Screens/ad_info.dart';
import 'package:campus_share/services/share_price.dart';
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
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[400], width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 130,
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
            SharePrice(price).priceShare(),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      location,
                      style: Theme.of(context).textTheme.headline3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
