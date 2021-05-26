import 'package:campus_share/models/advertisement.dart';
import 'package:campus_share/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Advertisements with ChangeNotifier {
  List<Advertisement> _ads = [];
  List<Advertisement> _userAds = [];
  CollectionReference col =
      FirebaseFirestore.instance.collection('Advertisments');
  final AuthService _auth = AuthService();

  List<Advertisement> get ads {
    return [..._ads];
  }

  List<Advertisement> get userAds {
    _userAds.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return [..._userAds];
  }

  Future<void> fetchAllAd() async {
    Query query = col;
    try {
      final List<Advertisement> loadedAds = [];
      await query.where('markassold', isEqualTo: false).get().then(
            (value) => value.docs.forEach(
              (ad) {
                final newAd = Advertisement(
                  adid: ad['adid'],
                  category: ad['category'],
                  contactinfo: ad['contactinfo'],
                  description: ad['description'],
                  location: ad['location'],
                  timestamp: DateTime.parse(ad['timestamp']),
                  title: ad['title'],
                  imageUrl: ad['image'],
                  price: double.parse(ad['price']),
                  markassold: ad['markassold'],
                  reportcount: ad['reportcount'],
                  sellerid: ad['sellerid'],
                );
                loadedAds.add(newAd);
              },
            ),
          );
      print('recall');
      _ads = loadedAds;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchAllAdBasedOnUser() async {
    Query query = col;
    try {
      final List<Advertisement> loadedAds = [];
      await query
          .where('sellerid', isEqualTo: _auth.authUser.currentUser.uid)
          .get()
          .then((value) => value.docs.forEach((ad) {
                final newAd = Advertisement(
                  adid: ad['adid'],
                  category: ad['category'],
                  contactinfo: ad['contactinfo'],
                  description: ad['description'],
                  location: ad['location'],
                  timestamp: DateTime.parse(ad['timestamp']),
                  title: ad['title'],
                  imageUrl: ad['image'],
                  price: double.parse(ad['price']),
                  markassold: ad['markassold'],
                  reportcount: ad['reportcount'],
                  sellerid: ad['sellerid'],
                );
                loadedAds.add(newAd);
              }));
      print('recall-2');
      _userAds = loadedAds;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
