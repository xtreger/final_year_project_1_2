import 'package:final_year_project_1_2/config/palette.dart';
import 'package:final_year_project_1_2/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
      authProviders: const AuthProviders(
        emailAndPassword: true,
        google: true,
        apple: true,
        twitter: true,
      ),
      child: MaterialApp(
        title: "Safe Parcel",
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.muliTextTheme(),
            accentColor: Palette.buttercup,
            appBarTheme: const AppBarTheme(
                brightness: Brightness.dark, color: Palette.dark)),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
