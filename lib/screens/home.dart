import 'package:final_year_project_1_2/config/appbartext.dart';
import 'package:final_year_project_1_2/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _streamUrl;
  VlcPlayerController _vlcPlayerController;

  @override
  void initState() {
    super.initState();
    _vlcPlayerController = new VlcPlayerController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _incrementCounter());
  }

  void _incrementCounter() {
    setState(() {
      _streamUrl = "http://192.168.0.115:5000/Fas3Tdg4Ffg2DF5DertThG";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(title: "Home"),
        backgroundColor: Palette.dark,
      ),
      body: Center(
        child: ListView(
          children: [
            Container(

                margin: const EdgeInsets.only(top: 10, left: 5.0, right: 5.0),
                child: Material(
                    color: Palette.dark,
                    elevation: 30,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "  Front Door Camera ",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          WidgetSpan(
                            child: Icon(Icons.live_tv_rounded,
                                size: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ))),
            _streamUrl == null
                ? Container()
                : Container(
                    margin: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10),
                    child: Material(
                        elevation: 20,
                        child: new VlcPlayer(
                          defaultHeight: 540,
                          defaultWidth: 1080,
                          url: _streamUrl,
                          controller: _vlcPlayerController,
                          placeholder: Container(),
                        ))),
            RaisedButton(
                onPressed: () async {
                  await http.get("http://192.168.0.11/?lighton");
                },
                child: const Text('Unlock')),
            RaisedButton(
                onPressed: () {
                  context.signOut();
                },
                child: const Text('Sign out')),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: (Icon(Icons.refresh )),
      // ),
    );
  }
}
