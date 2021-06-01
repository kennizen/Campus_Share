import 'package:campus_share/Widgets/ad_grid_item.dart';
import 'package:campus_share/providers/ad_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdGrid extends StatelessWidget {
  final String cat;

  AdGrid(this.cat);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: cat == ''
            ? Provider.of<Advertisements>(context, listen: false).fetchAllAd()
            : Provider.of<Advertisements>(context, listen: false)
                .fetchAllAdBrowse(cat),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Advertisements>(
                builder: (context, value, child) => Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  margin: const EdgeInsets.only(top: 10),
                  color: Colors.white,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 240,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount:
                        cat == '' ? value.ads.length : value.adsBrowse.length,
                    itemBuilder: (context, index) => cat == ''
                        ? AdGridItem(
                            location: value.ads[index].location,
                            price: value.ads[index].price,
                            title: value.ads[index].title,
                            imageUrl: value.ads[index].imageUrl,
                            adid: value.ads[index].adid,
                          )
                        : AdGridItem(
                            location: value.adsBrowse[index].location,
                            price: value.adsBrowse[index].price,
                            title: value.adsBrowse[index].title,
                            imageUrl: value.adsBrowse[index].imageUrl,
                            adid: value.adsBrowse[index].adid,
                          ),
                  ),
                ),
              ),
      ),
    );
  }
}
