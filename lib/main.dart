import 'package:flutter/material.dart';
import 'package:habisitic/pages/MyHabitsPage.dart';
import 'package:habisitic/pages/MyProgressPage.dart';
import 'package:habisitic/pages/PremiumPage.dart';
import 'package:habisitic/pages/SettingsPage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyNavigationBar(currentIndex: 0),
    );
  }
}

class MyNavigationBar extends StatefulWidget {
  final int currentIndex;
  MyNavigationBar({Key key, this.currentIndex}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  @override
  void initState() {
    _selectedIndex = widget.currentIndex;
    super.initState();
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (_selectedIndex) {
      case 0:
        child = MyHabitsPage();
        break;
      case 1:
        child = ProgressPage();
        break;
      case 2:
        child = SettingsPage();
        break;
      case 3:
        child = PremimumPage();
        break;
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Icon(
                Icons.add_box,
              ),
            ),
            label: 'My Habits',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Icon(Icons.show_chart_rounded),
            ),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Icon(
                Icons.settings,
              ),
            ),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Icon(
                Icons.workspace_premium,
              ),
            ),
            label: 'Premium',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: HexColor('#EFEFEF'),
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        selectedLabelStyle: GoogleFonts.openSans(fontSize: 13),
        unselectedLabelStyle: GoogleFonts.openSans(fontSize: 13),
        selectedItemColor: HexColor('#5353FF'),
        unselectedItemColor: HexColor('#919191'),
        iconSize: 24,
        onTap: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
      ),
    );
  }
}
