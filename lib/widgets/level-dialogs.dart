import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../models/Database.dart';

class Level1Finish extends StatefulWidget {
  const Level1Finish({Key key}) : super(key: key);

  @override
  State<Level1Finish> createState() => _Level1FinishState();
}

class _Level1FinishState extends State<Level1Finish> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                CircularPercentIndicator(
                  animateFromLastPercent: true,
                  startAngle: 180,
                  radius: 45,
                  backgroundColor: Colors.transparent,
                  progressColor: HexColor('#FFBE29'),
                  percent: 0.8,
                  center: PreferenceBuilder(
                    preference: Database.prefs
                        .getString("profilephotopath", defaultValue: "none"),
                    builder: (context, value) => (value == "none")
                        ? CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Center(
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            backgroundImage: MemoryImage(
                              Uint8List.fromList(File(value).readAsBytesSync()),
                            ),
                          ),
                  ),
                ),
                Positioned(
                  bottom: -3,
                  child: Container(
                    width: 44,
                    height: 18,
                    decoration: BoxDecoration(
                      color: HexColor('FFB100'),
                      shape: BoxShape.rectangle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                        colors: [
                          HexColor('#FFBE29'),
                          HexColor('#D8A42F'),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'LEVEL 1',
                        style: GoogleFonts.openSans(
                          fontSize: 7,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Only 2 of 14 days remaining!',
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: HexColor('#777777'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'WooHoo! You tracked all you habits\ntoday',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Awesome',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LevelUp extends StatefulWidget {
  const LevelUp({Key key}) : super(key: key);

  @override
  State<LevelUp> createState() => _LevelUpState();
}

class _LevelUpState extends State<LevelUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      insetPadding: EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You just levelled up!',
            style: GoogleFonts.openSans(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      CircularPercentIndicator(
                        animateFromLastPercent: true,
                        startAngle: 180,
                        radius: 45,
                        backgroundColor: Colors.transparent,
                        progressColor: HexColor('#FFBE29'),
                        percent: 1,
                        center: PreferenceBuilder(
                          preference: Database.prefs.getString(
                              "profilephotopath",
                              defaultValue: "none"),
                          builder: (context, value) => (value == "none")
                              ? CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: Center(
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
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
                        bottom: -3,
                        child: Container(
                          width: 44,
                          height: 18,
                          decoration: BoxDecoration(
                            color: HexColor('FFB100'),
                            shape: BoxShape.rectangle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                              colors: [
                                HexColor('#FFBE29'),
                                HexColor('#D8A42F'),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'LEVEL 1',
                              style: GoogleFonts.openSans(
                                fontSize: 7,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_right, color: HexColor('#C1C1C1')),
                Icon(Icons.arrow_right, color: HexColor('#C1C1C1')),
                Icon(Icons.arrow_right, color: HexColor('#C1C1C1')),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: CircularPercentIndicator(
                        animateFromLastPercent: true,
                        startAngle: 180,
                        radius: 45,
                        backgroundColor: Colors.transparent,
                        progressColor: HexColor('#B100FF'),
                        percent: 1,
                        center: PreferenceBuilder(
                          preference: Database.prefs.getString(
                              "profilephotopath",
                              defaultValue: "none"),
                          builder: (context, value) => (value == "none")
                              ? CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: Center(
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: MemoryImage(
                                    Uint8List.fromList(
                                        File(value).readAsBytesSync()),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -3,
                      child: Container(
                        width: 44,
                        height: 18,
                        decoration: BoxDecoration(
                          color: HexColor('FFB100'),
                          shape: BoxShape.rectangle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                            colors: [
                              HexColor('#CE00FF'),
                              HexColor('#AA00E8'),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'LEVEL 2',
                            style: GoogleFonts.openSans(
                              fontSize: 7,
                              color: Colors.white,
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
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              'You’ve tracked all your habits for \n14 days straight',
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 11.0),
            child: Text(
              '95% of the users reach level 2',
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w400,
                color: HexColor('#777777'),
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 29.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'I’ll Share later',
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w400,
                  color: HexColor('#777777'),
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
