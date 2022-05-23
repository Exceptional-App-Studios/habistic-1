import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:habisitic/models/myhabitmodel.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../main.dart';

class Database {
  static StreamingSharedPreferences prefs;

  static Future<void> initialize() async {
    prefs = await StreamingSharedPreferences.instance;
  }

  static editProfilePhoto(context, parentState) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                actions: [
                  RaisedButton(
                    color: Colors.black,
                    onPressed: () {
                      parentState.setState(() {});
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                title: Text("Edit Profile Photo",
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Color(0xff2D2D2D),
                content: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          child: PreferenceBuilder(
                              preference: Database.prefs.getString(
                                  "profilephotopath",
                                  defaultValue: "none"),
                              builder: (context, value) => CircleAvatar(
                                  radius: 67,
                                  backgroundImage: (value == "none")
                                      ? null
                                      : MemoryImage(
                                          Uint8List.fromList(
                                              File(value).readAsBytesSync()),
                                        ))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          color: Colors.black,
                          onPressed: () async {
                            ImagePicker imagePicker = ImagePicker();
                            PickedFile pic = await imagePicker.getImage(
                                source: ImageSource.gallery);
                            if (pic != null) {
                              File profilePhoto = File(pic.path);
                              File temp = await profilePhoto.copy(join(
                                  (await getApplicationDocumentsDirectory())
                                      .path,
                                  'profilePhoto.jpg'));

                              Database.prefs
                                  .setString("profilephotopath", temp.path)
                                  .then((_) {
                                setState(() {});
                              });
                            }
                          },
                          child: Text(
                            "Change Image",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  static editMiniGoal(context, parentState) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                actions: [
                  RaisedButton(
                    color: Colors.black,
                    onPressed: () {
                      parentState.setState(() {});
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                title: Text("Edit Profile Photo",
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Color(0xff2D2D2D),
                content: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          child: PreferenceBuilder(
                              preference: Database.prefs.getString(
                                  "profilephotopath",
                                  defaultValue: "none"),
                              builder: (context, value) => CircleAvatar(
                                  radius: 67,
                                  backgroundImage: (value == "none")
                                      ? null
                                      : MemoryImage(
                                          Uint8List.fromList(
                                              File(value).readAsBytesSync()),
                                        ))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          color: Colors.black,
                          onPressed: () async {
                            ImagePicker imagePicker = ImagePicker();
                            PickedFile pic = await imagePicker.getImage(
                                source: ImageSource.gallery);
                            if (pic != null) {
                              File profilePhoto = File(pic.path);
                              File temp = await profilePhoto.copy(join(
                                  (await getApplicationDocumentsDirectory())
                                      .path,
                                  'profilePhoto.jpg'));

                              Database.prefs
                                  .setString("profilephotopath", temp.path)
                                  .then((_) {
                                setState(() {});
                              });
                            }
                          },
                          child: Text(
                            "Change Image",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

class Practice {
  static checkPractice() async {
    Box<MyHabitModel> dataBox = Hive.box<MyHabitModel>(dataBoxName);

    DateTime checkdate = DateTime.now();
    String date = checkdate.day.toString() +
        ":" +
        checkdate.month.toString() +
        ":" +
        checkdate.year.toString();
    String morningdate = Database.prefs
        .getString("morningdate", defaultValue: "none")
        .getValue();
    if (morningdate != date) {
      await Database.prefs.setString("morningdate", date);
      await Database.prefs.setInt('done', 0);
      for (var i = 0; i < dataBox.length; i++) {
        await dataBox.putAt(
          i,
          MyHabitModel(
            avgtime: dataBox.getAt(i).avgtime,
            complete: false,
            minigoal: dataBox.getAt(i).minigoal,
            name: dataBox.getAt(i).name,
            reminder: dataBox.getAt(i).reminder,
            todaytime: 0,
            totaldays: dataBox.getAt(i).totaldays,
            totaltime: dataBox.getAt(i).totaltime,
            type: dataBox.getAt(i).type,
            donedates: dataBox.getAt(i).donedates,
            trackway: dataBox.getAt(i).trackway,
            everydaytime: dataBox.getAt(i).everydaytime,
            streak: dataBox.getAt(i).streak,
          ),
        );
      }
    }
  }
}

class CheckStreak {
  static calBestStreak() {
    Box<MyHabitModel> dataBox = Hive.box<MyHabitModel>(dataBoxName);
    List<String> donedates;

    for (var i = 0; i < dataBox.length; i++) {
      donedates = dataBox.getAt(i).donedates;
      if (donedates.isNotEmpty) {
        DateTime pre = DateTime(
            int.parse(donedates.last.split("-")[2]),
            int.parse(donedates.last.split("-")[1]),
            int.parse(donedates.last.split("-")[0]));

        DateFormat dateFormat = DateFormat("dd-MM-yyyy");
        String string = dateFormat.format(DateTime.now());
        DateTime now = dateFormat.parse(string);
        int difference = now.difference(pre).inDays;
        print("Now: $now");
        print("Pre: $pre");
        print("String: $string");
        print("Difference: $difference");
        if (difference > 1) {
          dataBox.putAt(
            i,
            MyHabitModel(
              avgtime: dataBox.getAt(i).avgtime,
              complete: false,
              minigoal: dataBox.getAt(i).minigoal,
              name: dataBox.getAt(i).name,
              reminder: dataBox.getAt(i).reminder,
              todaytime: dataBox.getAt(i).todaytime,
              totaldays: dataBox.getAt(i).totaldays,
              totaltime: dataBox.getAt(i).totaltime,
              type: dataBox.getAt(i).type,
              donedates: dataBox.getAt(i).donedates,
              trackway: dataBox.getAt(i).trackway,
              everydaytime: dataBox.getAt(i).everydaytime,
              streak: 0,
            ),
          );
          // print(streak);
        }
        pre = now;
      }
    }
  }
}
