import 'package:campus_share/models/advertisement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  final CollectionReference advertisments =
      FirebaseFirestore.instance.collection('Advertisments');

  Future createUser({
    String username,
    String email,
    String pImage,
    String uid,
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

  Future updateAd(Advertisement ad) async {
    try {
      await advertisments.doc(ad.adid).update({
        'title': ad.title,
        'description': ad.description,
        'location': ad.location,
        'price': ad.price.toString(),
        'image': ad.imageUrl,
        'category': ad.category,
        'contactinfo': ad.contactinfo,
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> reportAd(String adid) async {
    try {
      DocumentSnapshot snap = await advertisments.doc(adid).get();
      var oldReportCount = snap.get('reportcount');
      await advertisments.doc(adid).update({'reportcount': oldReportCount + 1});
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateProfileImage(String uid, String url) async {
    try {
      await users.doc(uid).update({'pImage': url});
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> deleteAd(String adid) async {
    try {
      await advertisments.doc(adid).delete();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
