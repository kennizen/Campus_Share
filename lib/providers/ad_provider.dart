import 'package:campus_share/models/advertisement.dart';
import 'package:flutter/material.dart';

class Advertisements with ChangeNotifier {
  List<Advertisement> _ads = [
    Advertisement(
      adid: '1',
      category: 'Cycle',
      contactinfo: 'xyz@gmail.com',
      description: 'A very nice product',
      location: 'PMH',
      price: 220,
      sellerid: '1',
      timestamp: DateTime.now(),
      title: 'Bike',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Advertisement(
      adid: '2',
      category: 'Others',
      contactinfo: 'xyz@gmail.com',
      description: 'A very nice product',
      location: 'KMH',
      sellerid: '1',
      timestamp: DateTime.now(),
      title: 'Coffee Mug',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Advertisement(
      adid: '3',
      category: 'Instruments',
      contactinfo: 'xyz@gmail.com',
      description: 'A very nice product',
      location: 'PMH',
      price: 520,
      sellerid: '2',
      timestamp: DateTime.now(),
      title: 'Guitar',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Advertisement(
      adid: '4',
      category: 'Books',
      contactinfo: 'xyz@gmail.com',
      description: 'A very nice product',
      location: 'NWH',
      sellerid: '3',
      timestamp: DateTime.now(),
      title: 'DBMS',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
  ];

  List<Advertisement> get ads {
    return [..._ads];
  }
}
