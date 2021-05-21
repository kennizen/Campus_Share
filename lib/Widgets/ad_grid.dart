import 'package:campus_share/Widgets/ad_grid_item.dart';
import 'package:campus_share/providers/ad_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ads = Provider.of<Advertisements>(context).ads;
    return Expanded(
      flex: 1,
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 3,
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) => AdGridItem(
          location: ads[index].location,
          price: ads[index].price,
          title: ads[index].title,
          imageUrl: ads[index].imageUrl,
          adid: ads[index].adid,
        ),
        itemCount: ads.length,
      ),
    );
  }
}
