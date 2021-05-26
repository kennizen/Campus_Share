import 'package:campus_share/Screens/Authenticate/authenticate.dart';
import 'package:campus_share/Screens/bottom_nav_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user == null ? Authenticate() : BottomNavScreen();
  }
}
