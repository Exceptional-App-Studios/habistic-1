import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:habisitic/models/myhabitmodel.dart';
import 'package:hive/hive.dart';
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
            minigoal: dataBox.getAt(i).avgtime,
            name: dataBox.getAt(i).name,
            reminder: dataBox.getAt(i).reminder,
            todaytime: 0,
            totaldays: dataBox.getAt(i).totaldays,
            totaltime: dataBox.getAt(i).totaltime,
            type: dataBox.getAt(i).type,
            donedates: dataBox.getAt(i).donedates,
          ),
        );
      }
    }
  }
}

class Calculations {
  static calBestStreak() {
    // List<dynamic> donedates = Hive.box('donedates').get(0);

    Box<MyHabitModel> dataBox = Hive.box<MyHabitModel>(dataBoxName);

    List<String> donedates =
        Database.prefs.getStringList("donedates", defaultValue: []).getValue();
    if (donedates.isNotEmpty) {
      // int beststreak = 1;
      int streak = 1;
      DateTime pre = DateTime(
          int.parse(dataBox.getAt(0).donedates[0].split(":")[2]),
          int.parse(dataBox.getAt(0).donedates[0].split(":")[1]),
          int.parse(dataBox.getAt(0).donedates[0].split(":")[0]));

      for (int i = 1; i < donedates.length; i++) {
        DateTime next = DateTime(
            int.parse(dataBox.getAt(i).donedates[i].split(":")[2]),
            int.parse(dataBox.getAt(i).donedates[0].split(":")[1]),
            int.parse(dataBox.getAt(i).donedates[0].split(":")[0]));
        int difference = next.difference(pre).inDays;
        if (difference == 1) {
          streak = streak + 1;
        } else {
          streak = 1;
        }
        pre = next;
      }
      // print(beststreak);

      Database.prefs.setInt("streak", streak);
    }
  }
}
