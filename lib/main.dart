import 'package:flutter/material.dart';
import 'package:habisitic/models/Database.dart';
import 'package:habisitic/models/myhabitmodel.dart';
import 'package:habisitic/pages/MyHabitsPage.dart';
import 'package:habisitic/pages/MyProgressPage.dart';
import 'package:habisitic/pages/PremiumPage.dart';
import 'package:habisitic/pages/SettingsPage.dart';
import 'package:habisitic/services/notification_service.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:onboarding/onboarding.dart';
import 'package:path_provider/path_provider.dart';

const String dataBoxName = "data";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Database.initialize();
  Hive.init(document.path);
  Hive.registerAdapter(MyHabitModelAdapter());
  await Hive.openBox<MyHabitModel>(dataBoxName);
  await Database.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    materialButton = _nextButton;
    NotificationApi.init();
    super.initState();
  }

  Material materialButton;

  final onboardingPagesList = [
    PageModel(
      widget: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 100.0,
              bottom: 10.0,
            ),
            child: Image.asset(
              'assets/logo.png',
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'HABISTIC',
              style: GoogleFonts.openSans(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: HexColor('#015DFF'),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 81),
            alignment: Alignment.center,
            child: Text(
              'Make your habits stick',
              style: GoogleFonts.openSans(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 27),
            alignment: Alignment.center,
            child: Text(
              'Habistic will help you create new habits,\nand stick to your habits more fun\nand encouraging for long-term.',
              style: GoogleFonts.openSans(
                fontSize: 20,
                color: HexColor('#868686'),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 100.0,
              bottom: 10.0,
            ),
            child: Image.asset(
              'assets/onboarding_1.png',
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 52.7),
            alignment: Alignment.center,
            child: Text(
              'Stay happy, healthy &\nProductive',
              style: GoogleFonts.openSans(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 24),
            alignment: Alignment.center,
            child: Text(
              'Build habits that will help you lead.\nA happy healthy and successful life',
              style: GoogleFonts.openSans(
                fontSize: 20,
                color: HexColor('#868686'),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
    PageModel(
      widget: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 100.0,
                bottom: 10.0,
              ),
              child: Image.asset(
                'assets/logo.png',
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'HABISTIC',
                style: GoogleFonts.openSans(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#015DFF'),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 109),
              alignment: Alignment.center,
              child: Text(
                'What should we call you?',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 32, right: 32),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your name',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ];

  set _buildButton(int pageIndex) {
    if (pageIndex == 0) {
      setState(() {
        materialButton = _nextButton;
      });
    } else if (pageIndex == 1) {
      setState(() {
        materialButton = _getStarted0;
      });
    } else if (pageIndex == 2) {
      setState(() {
        materialButton = _getStarted1;
      });
    }
  }

  Material get _getStarted1 {
    return Material(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50.0),
      ),
      color: HexColor('#505BF6'),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyNavigationBar(
              currentIndex: 0,
            ),
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          width: 210,
          height: 66,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Get Started',
                  style: GoogleFonts.openSans(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Material get _nextButton {
    return Material(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50.0),
      ),
      color: HexColor('#505BF6'),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          width: 210,
          height: 66,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'NEXT',
                style: GoogleFonts.openSans(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 40),
              Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  Material get _getStarted0 {
    return Material(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50.0),
      ),
      color: HexColor('#505BF6'),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          width: 210,
          height: 66,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Get Started',
                  style: GoogleFonts.openSans(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyNavigationBar(
          currentIndex: 0,
        )
        // Onboarding(
        //   background: Colors.white,
        //   pages: onboardingPagesList,
        //   onPageChange: (int pageIndex) {
        //     _buildButton = pageIndex;
        //   },
        //   footer: Footer(
        //     secondChild: materialButton,
        //     child: Container(),
        //     indicator: Indicator(
        //       indicatorDesign: IndicatorDesign.polygon(
        //         polygonDesign: PolygonDesign(
        //             polygon: DesignType.polygon_circle, polygonRadius: 4),
        //       ),
        //       activeIndicator: ActiveIndicator(color: Colors.grey),
        //       closedIndicator: ClosedIndicator(
        //         color: HexColor('#5353FF'),
        //       ),
        //     ),
        //     footerPadding: const EdgeInsets.only(left: 45.0, bottom: 25),
        //     indicatorPosition: IndicatorPosition.none,
        //   ),
        // ),
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
              flex: 1,
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
