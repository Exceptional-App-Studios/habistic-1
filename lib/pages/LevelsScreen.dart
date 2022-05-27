import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../models/Database.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key key}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  int totaldays =
      Database.prefs.getInt('totaldays', defaultValue: 0).getValue();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Text(
                'Build a winner’s mindset',
                style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 30),
              child: Text(
                ' Clear all the levels and have the ultimate self\nconfidence of creating any habit you want. When you\nreach level 4 you’ll be having ultimate confidence\nof creating habits',
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              color: HexColor('#C1C1C1'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 33),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  totaldays > 64
                      ? Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            PreferenceBuilder(
                              preference: Database.prefs.getString(
                                  "profilephotopath",
                                  defaultValue: "none"),
                              builder: (context, value) => (value == "none")
                                  ? Container(
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                          style: BorderStyle.solid,
                                          color: Colors.black,
                                          width: 4,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 44,
                                        backgroundColor: Colors.white,
                                        child: Center(
                                          child: Icon(
                                            Icons.add_a_photo_outlined,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                          style: BorderStyle.solid,
                                          color: Colors.black,
                                          width: 6,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: MemoryImage(
                                          Uint8List.fromList(
                                              File(value).readAsBytesSync()),
                                        ),
                                      ),
                                    ),
                            ),
                            Positioned(
                              top: 65,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: Center(
                                  child: Text(
                                    'LEVEL 4',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 90.0,
                              height: 90.0,
                              decoration: new BoxDecoration(
                                // color: Colors.black,
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 10,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: new BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    )),
                              ),
                            ),
                            Positioned(
                              top: 55,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: Center(
                                  child: Text(
                                    'LEVEL 4',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Master: 121 Days 🔥',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Only 5% of the users can\nreach this level',
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: HexColor('#777777'),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50, top: 68),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 38.0, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Advance: 64 Days 🔥',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Only 47% of the users can\nreach this level',
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: HexColor('#777777'),
                          ),
                        )
                      ],
                    ),
                  ),
                  totaldays >= 31 && totaldays < 64
                      ? Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            PreferenceBuilder(
                              preference: Database.prefs.getString(
                                  "profilephotopath",
                                  defaultValue: "none"),
                              builder: (context, value) => (value == "none")
                                  ? Container(
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                          style: BorderStyle.solid,
                                          color: HexColor('#6665BD'),
                                          width: 4,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 44,
                                        backgroundColor: Colors.white,
                                        child: Center(
                                          child: Icon(
                                            Icons.add_a_photo_outlined,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                          style: BorderStyle.solid,
                                          color: HexColor('#6665BD'),
                                          width: 6,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: MemoryImage(
                                          Uint8List.fromList(
                                              File(value).readAsBytesSync()),
                                        ),
                                      ),
                                    ),
                            ),
                            Positioned(
                              top: 65,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: 30,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    colors: [
                                      HexColor('#FFB95A'),
                                      HexColor('#6464BE')
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: Center(
                                  child: Text(
                                    'LEVEL 3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 90.0,
                              height: 90.0,
                              decoration: new BoxDecoration(
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: HexColor('#6665BD'),
                                  width: 10,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: new BoxDecoration(
                                      color: HexColor('#6665BD'),
                                      shape: BoxShape.circle,
                                    )),
                              ),
                            ),
                            Positioned(
                              top: 55,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    colors: [
                                      HexColor('#FFB95A'),
                                      HexColor('#6464BE')
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: Center(
                                  child: Text(
                                    'LEVEL 3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 73),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  totaldays > 7
                      ? Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            PreferenceBuilder(
                              preference: Database.prefs.getString(
                                  "profilephotopath",
                                  defaultValue: "none"),
                              builder: (context, value) => (value == "none")
                                  ? Container(
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                          style: BorderStyle.solid,
                                          color: HexColor('#AA00E8'),
                                          width: 4,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 44,
                                        backgroundColor: Colors.white,
                                        child: Center(
                                          child: Icon(
                                            Icons.add_a_photo_outlined,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                          style: BorderStyle.solid,
                                          color: HexColor('#AA00E8'),
                                          width: 6,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: MemoryImage(
                                          Uint8List.fromList(
                                              File(value).readAsBytesSync()),
                                        ),
                                      ),
                                    ),
                            ),
                            Positioned(
                              top: 65,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: 30,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    colors: [
                                      HexColor('#FF7A27'),
                                      HexColor('#AA00E8')
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: Center(
                                  child: Text(
                                    'LEVEL 2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 90.0,
                              height: 90.0,
                              decoration: new BoxDecoration(
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: HexColor('#BB1BC2'),
                                  width: 10,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: new BoxDecoration(
                                      color: HexColor('#BB1BC2'),
                                      shape: BoxShape.circle,
                                    )),
                              ),
                            ),
                            Positioned(
                              top: 55,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    colors: [
                                      HexColor('#FF7A27'),
                                      HexColor('#AA00E8')
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: Center(
                                  child: Text(
                                    'LEVEL 2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Intermediate: 31 Days 🔥',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Only 67% of the users can\nreach this level',
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: HexColor('#777777'),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50, top: 68),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 38.0, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Beginner level : 14 Days 🔥',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Don’t miss any habit for at\nleast 14 days',
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: HexColor('#777777'),
                          ),
                        )
                      ],
                    ),
                  ),
                  totaldays < 7
                      ? Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            PreferenceBuilder(
                              preference: Database.prefs.getString(
                                  "profilephotopath",
                                  defaultValue: "none"),
                              builder: (context, value) => (value == "none")
                                  ? Container(
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                          style: BorderStyle.solid,
                                          color: HexColor('#FFB100'),
                                          width: 4,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 44,
                                        backgroundColor: Colors.white,
                                        child: Center(
                                          child: Icon(
                                            Icons.add_a_photo_outlined,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                          style: BorderStyle.solid,
                                          color: HexColor('#FFB100'),
                                          width: 6,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: MemoryImage(
                                          Uint8List.fromList(
                                              File(value).readAsBytesSync()),
                                        ),
                                      ),
                                    ),
                            ),
                            Positioned(
                              top: 65,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4.5,
                                height: 30,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    colors: [
                                      HexColor('#FFB100'),
                                      HexColor('#CB635A')
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: Center(
                                  child: Text(
                                    'LEVEL 1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 90.0,
                              height: 90.0,
                              decoration: new BoxDecoration(
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: HexColor('#FFB100'),
                                  width: 10,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: new BoxDecoration(
                                      color: HexColor('#FFB100'),
                                      shape: BoxShape.circle,
                                    )),
                              ),
                            ),
                            Positioned(
                              top: 55,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    colors: [
                                      HexColor('#FFB100'),
                                      HexColor('#CB635A')
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: Center(
                                  child: Text(
                                    'LEVEL 1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
