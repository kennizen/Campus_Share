import 'package:campus_share/models/advertisement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  final CollectionReference advertisments =
      FirebaseFirestore.instance.collection('Advertisments');

  Future createUser({
    String username,
    String email,
    String pImage,
  }) async {
    return await users.doc(uid).set({
      'username': username,
      'email': email,
      'pImage': pImage,
      'joinDate': DateTime.now().toIso8601String(),
    });
  }

  Future createAd(Advertisement ad) async {
    try {
      await advertisments.doc(ad.adid).set({
        'adid': ad.adid,
        'title': ad.title,
        'description': ad.description,
        'location': ad.location,
        'price': ad.price.toString(),
        'image': ad.imageUrl,
        'markassold': ad.markassold,
        'category': ad.category,
        'reportcount': ad.reportcount,
        'contactinfo': ad.contactinfo,
        'timestamp': ad.timestamp.toIso8601String(),
        'sellerid': ad.sellerid,
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future markAsSold(String adid, bool val) async {
    try {
      await advertisments.doc(adid).update({
        'markassold': val,
      });
    } catch (e) {
      print(e);
      return null;
    }
  }
}
