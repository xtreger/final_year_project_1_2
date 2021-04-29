import 'package:final_year_project_1_2/config/appbartext.dart';
import 'package:final_year_project_1_2/config/palette.dart';
import 'package:final_year_project_1_2/screens/auth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);


  static MaterialPageRoute get route => MaterialPageRoute(
    builder: (context) => const Settings(),
  );


  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  double value = 500;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(title: "Settings"),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Palette.cobalt,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                        leading: Icon(
                          Icons.motion_photos_on,
                          color: Colors.white,
                        ),
                        title: Text('Motion Sensitivity',
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text("You can adjust the motion sensor sensitivity by draggin the slider below, the higher it is the less motion it will detect.",
                            style: const TextStyle(color: Colors.white60))),
                  ],
                ),
              )),
          Slider(
            value: value,
            min: 0,
            max: 1000,
            divisions: 1000,
            activeColor: Palette.cobalt,
            inactiveColor: Palette.cobaltShade,
            label: value.round().toString(),
            onChanged: (value) => setState(() => this.value = value),

          ),
          Container(
              margin: const EdgeInsets.only(
                  left: 5.0, right: 5.0, bottom: 10),
              child: Material(
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 10.0,
                        left: 40.0,
                        right: 40.0,
                        bottom: 20.0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20.0)),
                        highlightElevation: 5.0,
                        hoverColor: Colors.white,
                        color: Palette.cobalt,
                        onPressed: () {
                        },
                        child: const Text('Set Sensitivity',
                            style: const TextStyle(
                                color: Colors.white))),
                  )
              ))
        ],
      ),
      floatingActionButton: Builder(
        builder: (BuildContext context) {
            return FloatingActionButton.extended(
                onPressed: () async {
                  context.signOut();
                  Navigator.of(context).pushReplacement(AuthenticationScreen.route);
                  super.dispose();
                },
                backgroundColor: Colors.redAccent,
                label: const Text(
                  "Logout",
                  style: const TextStyle(color: Colors.white),
                ),
                icon: const Icon(Icons.logout, color: Colors.white));
        },
      ),
    );
  }
}

