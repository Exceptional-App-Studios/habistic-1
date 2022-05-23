import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Database.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool syncData = true;
  bool isEditing = false;
  String initialText;

  @override
  void initState() {
    String initialText =
        Database.prefs.getString('name', defaultValue: 'Your Name').getValue();
    print(initialText);
    nameController = TextEditingController(text: initialText);

    super.initState();
  }

  TextEditingController nameController;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    PreferenceBuilder(
                      preference: Database.prefs
                          .getString("profilephotopath", defaultValue: "none"),
                      builder: (context, value) => (value == "none")
                          ? CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.white,
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage: MemoryImage(
                                Uint8List.fromList(
                                    File(value).readAsBytesSync()),
                              ),
                            ),
                    ),
                    Positioned(
                      top: 70,
                      left: 65,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Database.editProfilePhoto(context, this);
                        },
                        child: CircleAvatar(
                          backgroundColor: HexColor('F4F0F0'),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isEditing
                ? Container(
                    width: 100,
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        autofocus: true,
                        cursorColor: Colors.black,
                        textAlign: TextAlign.center,
                        controller: nameController,
                        onSubmitted: (value) {
                          setState(() {
                            initialText = value;
                            Database.prefs.setString('name', value);
                            isEditing = false;
                          });
                        },
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PreferenceBuilder(
                          preference: Database.prefs
                              .getString('name', defaultValue: 'Your Name'),
                          builder: (context, value) => Text(
                            '$value',
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isEditing = true;
                            });
                          },
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: HexColor('#F8F8F8'),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              color: Colors.transparent,
                              height: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Sync data',
                                        style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Switch(
                                          value: syncData,
                                          activeColor: HexColor('#5353FF'),
                                          onChanged: (value) {
                                            setState(() {
                                              syncData = value;
                                            });
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                launchUrl(
                                  Uri.parse(
                                      'mailto:exceptionalappstudios@gmail.com?subject=Feedback for Habistic App'),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 30,
                                ),
                                color: Colors.transparent,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Contact Us',
                                      style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.mail_outline,
                                      color: HexColor('#777777'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.only(left: 20, right: 26),
                                color: Colors.transparent,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Share this app',
                                      style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle: -26,
                                      child: Icon(
                                        Icons.send_rounded,
                                        color: HexColor('#777777'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.only(left: 20, right: 27),
                                color: Colors.transparent,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'How to create a new habit',
                                      style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.ondemand_video_rounded,
                                      color: HexColor('#777777'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
