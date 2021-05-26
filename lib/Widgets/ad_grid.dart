import 'package:campus_share/Widgets/ad_grid_item.dart';
import 'package:campus_share/providers/ad_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FutureBuilder(
        future:
            Provider.of<Advertisements>(context, listen: false).fetchAllAd(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<Advertisements>(
                    builder: (context, value, child) => GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 3 / 3,
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: value.ads.length,
                      itemBuilder: (context, index) => AdGridItem(
                        location: value.ads[index].location,
                        price: value.ads[index].price,
                        title: value.ads[index].title,
                        imageUrl: value.ads[index].imageUrl,
                        adid: value.ads[index].adid,
                      ),
                    ),
                  ),
      ),
    );
  }
}
