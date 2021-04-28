import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project_1_2/screens/home.dart';
import 'package:final_year_project_1_2/config/palette.dart';
import 'package:final_year_project_1_2/screens/profile/profile.dart';

class BottomNav extends StatefulWidget {

  const BottomNav({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
    builder: (context) => const BottomNav(),
  );
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  int _selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    Text("messages"),
    Profile(),

  ];

  void _onItemTap(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded),
                label: "Message"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: "Profile"),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Palette.dark,
          unselectedItemColor: Palette.light,
          onTap: _onItemTap),
    );
  }
}
