import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project_1_2/screens/home.dart';
import 'package:final_year_project_1_2/config/palette.dart';
import 'package:final_year_project_1_2/screens/settings/settings.dart';
import 'package:final_year_project_1_2/screens/history/history.dart';

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
    History(),
    Settings(),

  ];

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTap(int index){
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: <Widget>[
            HomeScreen(),
            History(),
            Settings(),
          ],
        ),
      ),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded),
                label: "History"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded),
                label: "Settings"),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Palette.cobalt,
          unselectedItemColor: Palette.light,
          onTap: _onItemTap),
    );
  }
}
