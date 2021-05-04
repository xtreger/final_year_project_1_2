import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project_1_2/config/appbartext.dart';
import 'package:final_year_project_1_2/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

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
  final myController = TextEditingController();
  bool _validateVideo = false;
  bool _validateLock = false;
  bool _waitVideo = true;
  bool _waitLock = false;
  String data;
  String _userID;
  String _lockUrl;
  final lockController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    _userID = uid;
  }

  @override
  void initState() {
    super.initState();
    inputData();
    int motion = _getMotion() as int;
    _incrementCounter();
    _vlcPlayerController = new VlcPlayerController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _incrementCounter());
  }

  void _incrementCounter() {
    setState(() {
      SystemChrome.setEnabledSystemUIOverlays([]);
      getStreamID();
      getLockID();
    });
  }

  VlcPlayer getVLCFeed() {
    return new VlcPlayer(
      defaultHeight: 540,
      defaultWidth: 1080,
      url: _streamUrl,
      controller: _vlcPlayerController,
      placeholder: Container(
        padding: const EdgeInsets.only(bottom: 30.0, top: 30.0),
        child: Center(
            child: SpinKitCircle(
          color: Palette.cobalt,
          size: 50.0,
        )),
      ),
    );
  }

  addVideo() {
    Map<String, dynamic> videoData = {
      'streamID': myController.text.toString(),
      'userID': _userID
    };
    CollectionReference collectionReference =
        Firestore.instance.collection('videoData');
    collectionReference.add(videoData);
  }

  addLock() {
    Map<String, dynamic> videoData = {
      'lockID': lockController.text.toString(),
      'userID': _userID
    };
    CollectionReference collectionReference =
        Firestore.instance.collection('lockData');
    collectionReference.add(videoData);
  }

  void getStreamID() {
    CollectionReference collectionReference =
        Firestore.instance.collection('videoData');

    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        snapshot.documents.forEach((element) {
          _userID == element['userID']
              ? _streamUrl =
                  "http://192.168.0.115:5000/" + element.data['streamID']
              : _waitVideo = true;
        });
      });
    });
  }

  void getLockID() {
    CollectionReference collectionReference =
        Firestore.instance.collection('lockData');

    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        snapshot.documents.forEach((element) {
          _userID == element['userID']
              ? _lockUrl = "http://192.168.0.11/?" + element.data['lockID']
              : _waitLock = true;
        });
      });
    });
  }

  Future<String> _getMotion() async {
    String url = "http://192.168.0.115:5000/motion";
    Response response = await http.get(url);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    var values = responseJson.values.toList();
    String s = values[0].toString();
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: AppBarText(title: "Home"),
            backgroundColor: Colors.white,
          ),
          body: Center(
            child: ListView(
              children: [
                Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 5.0, right: 5.0),
                    child: Material(
                        color: Palette.cobalt,
                        elevation: 5,
                        child: _streamUrl != null && _streamUrl.length > 30
                            ? Container(
                                padding:
                                    const EdgeInsets.only(top: 3, bottom: 3),
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
                                ))
                            : null)),
                Container(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10),
                    child: Material(
                        child: (_streamUrl != null && _streamUrl.length > 30)
                            ? getVLCFeed()
                            : Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 40.0, right: 40.0),
                                // ignore: deprecated_member_use
                                child: TextField(
                                  controller: myController,
                                  decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Palette.cobalt),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Palette.cobalt),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      errorStyle: const TextStyle(
                                          color: Palette.cobalt),
                                      errorText: _validateVideo
                                          ? 'Invalid Device ID'
                                          : null,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Palette.cobalt),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Palette.cobalt),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      hintText: "Video Device ID"),
                                ),
                              ))),
                Container(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10),
                    child: Material(
                        child: (_streamUrl == null || _streamUrl.length < 30) &&
                                _waitVideo
                            ? Container(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    left: 40.0,
                                    right: 40.0,
                                    bottom: 20.0),
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    highlightElevation: 5.0,
                                    hoverColor: Colors.white,
                                    color: Palette.cobalt,
                                    onPressed: () {
                                      setState(() {
                                        myController.text.toString() !=
                                                "Fas3Tdg4Ffg2DF5DertThG"
                                            ? _validateVideo = true
                                            : _validateVideo = false;
                                        !_validateVideo ? addVideo() : null;
                                      });
                                    },
                                    child: const Text(
                                        'Add Video Streaming Device',
                                        style: const TextStyle(
                                            color: Colors.white))),
                              )
                            : null)),
                Container(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10),
                    child: Material(
                        child: _lockUrl == null && _waitLock
                            ? Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 40.0, right: 40.0),
                                // ignore: deprecated_member_use
                                child: TextField(
                                  controller: lockController,
                                  decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Palette.cobalt),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Palette.cobalt),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      errorStyle: const TextStyle(
                                          color: Palette.cobalt),
                                      errorText: _validateLock
                                          ? 'Invalid Safe Box ID'
                                          : null,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Palette.cobalt),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Palette.cobalt),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      hintText: "Safe Box ID"),
                                ),
                              )
                            : null)),
                Container(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10),
                    child: Material(
                        child: _lockUrl == null && _waitLock
                            ? Container(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    left: 40.0,
                                    right: 40.0,
                                    bottom: 20.0),
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    highlightElevation: 5.0,
                                    hoverColor: Colors.white,
                                    color: Palette.cobalt,
                                    onPressed: () {
                                      setState(() {
                                        lockController.text.toString() !=
                                                "Czetacrppb6c"
                                            ? _validateLock = true
                                            : _validateLock = false;
                                        !_validateLock ? addLock() : null;
                                      });
                                    },
                                    child: const Text('Connect to the Safe Box',
                                        style: const TextStyle(
                                            color: Colors.white))),
                              )
                            : null))
              ],
            ),
          ),
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              if (_lockUrl != null) {
                return FloatingActionButton.extended(
                    onPressed: () async {
                      await http.get(_lockUrl);
                    },
                    backgroundColor: Palette.cobalt,
                    label: const Text(
                      "Unlock",
                      style: const TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(Icons.lock_open_rounded,
                        color: Colors.white));
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
