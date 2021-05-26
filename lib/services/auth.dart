import 'package:campus_share/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get authUser {
    return _auth;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //sign in with email and password
  Future registerWithEmailAndPassword({
    String email,
    String password,
    String pImage,
    String username,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid).createUser(
        email: email,
        pImage: pImage,
        username: username,
      );
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword({String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout of the app
  Future signOutOfApp() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
