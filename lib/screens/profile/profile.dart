import 'package:final_year_project_1_2/screens/auth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);


  static MaterialPageRoute get route => MaterialPageRoute(
    builder: (context) => const Profile(),
  );


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            context.signOut();
            Navigator.of(context).pushReplacement(AuthenticationScreen.route);
            super.dispose();
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}