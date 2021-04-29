import 'package:final_year_project_1_2/config/appbartext.dart';
import 'package:final_year_project_1_2/config/palette.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const History(),
      );

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String now = new DateTime.now().toString();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(title: "History"),
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
                          Icons.lock_open_rounded,
                          color: Colors.white,
                        ),
                        title: Text('You have unlocked the box.',
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text("2021-04-30 13:23",
                            style: const TextStyle(color: Colors.white60))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('DELETE',
                              style: const TextStyle(color: Colors.white)),
                          onPressed: () {
                            /* ... */
                          },
                        )
                      ],
                    ),
                  ],
                ),
              )),
          Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.redAccent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                        leading: Icon(
                          Icons.warning_rounded,
                          color: Colors.white,
                        ),
                        title: Text('Potentially missed delivery!',
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text("2021-04-30 13:23",
                            style: const TextStyle(color: Colors.white60))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('DISMISS',
                              style: const TextStyle(color: Colors.white)),
                          onPressed: () {
                            /* ... */
                          },
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
