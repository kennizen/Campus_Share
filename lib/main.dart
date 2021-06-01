import 'package:campus_share/providers/ad_provider.dart';
import 'package:campus_share/services/auth.dart';
import 'package:campus_share/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Advertisements(),
        ),
        StreamProvider<User>.value(
          value: AuthService().user,
          initialData: null,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
          textTheme: TextTheme(
            bodyText1: GoogleFonts.openSans(
              fontSize: 16,
              color: Colors.blueGrey[700],
            ),
            headline2: GoogleFonts.openSans(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey[900],
            ),
            headline1: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.blueGrey[900],
            ),
            headline4: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.blueGrey[900],
            ),
            headline3: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.blueGrey[900],
            ),
            headline5: GoogleFonts.openSans(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.blueGrey[900],
            ),
          ),
        ),
        home: Wrapper(),
      ),
    );
  }
}
