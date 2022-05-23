import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habisitic/main.dart';
import 'package:habisitic/models/Database.dart';
import 'package:habisitic/models/myhabitmodel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class TimerPage extends StatefulWidget {
  final MyHabitModel habits;
  final int duration;
  final int index;
  const TimerPage({Key key, this.habits, this.duration, this.index})
      : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

var habit;
int duration;

class _TimerPageState extends State<TimerPage> {
  Box<MyHabitModel> dataBox;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    dataBox = Hive.box<MyHabitModel>(dataBoxName);

    habit = widget.habits;
    duration = widget.duration * 60;
    print(duration);

    Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        stopwatch.start();
        isPlaying = true;
      });
      if (stopwatch.elapsed.inSeconds == duration) {
        stopwatch.stop();
        isPaused = true;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    stopwatch.reset();
    super.dispose();
  }

  bool isPaused = false;
  bool isPlaying;
  int duration;
  Stopwatch stopwatch = Stopwatch();
  String date = DateFormat("dd-MM-yyy").format(DateTime.now());
  int done = Database.prefs.getInt('done', defaultValue: 0).getValue();
  int totaldays =
      Database.prefs.getInt('totaldays', defaultValue: 0).getValue();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Text(
          habit.name,
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 31),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 95,
                  backgroundColor: Colors.black,
                ),
                Center(
                  child: Text(
                    ((stopwatch.elapsed.inMinutes < 10)
                            ? "0" + stopwatch.elapsed.inMinutes.toString()
                            : stopwatch.elapsed.inMinutes.toString()) +
                        ":" +
                        (stopwatch.elapsed.inSeconds % 60 < 10
                            ? "0" +
                                (stopwatch.elapsed.inSeconds % 60).toString()
                            : (stopwatch.elapsed.inSeconds % 60).toString()),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(HexColor('#505BF6')),
                    strokeWidth: 8,
                    value: stopwatch.elapsed.inSeconds / duration,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 34.0),
            child: Text(
              'Timer Started',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          isPaused
              ? Padding(
                  padding: const EdgeInsets.only(top: 217, bottom: 10),
                  child: GestureDetector(
                    onTap: () async {
                      stopwatch.start();
                      setState(() {
                        isPaused = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'Resume',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 217, bottom: 10),
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        isPaused = true;
                      });
                      stopwatch.stop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'Pause',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: GestureDetector(
              onTap: () async {
                Database.prefs.getInt('done', defaultValue: 0);

                print("Done before: $done");
                print(dataBox.length);

                await Database.prefs.setInt(
                    'done',
                    Database.prefs.getInt('done', defaultValue: 0).getValue() +
                        1);

                if (Database.prefs.getInt('done', defaultValue: 0).getValue() ==
                    dataBox.length) {
                  Database.prefs.setInt('totaldays', totaldays + 1);
                }
                print("Done after: $done");

                await dataBox.put(
                  widget.index,
                  MyHabitModel(
                    name: habit.name,
                    avgtime: habit.avgtime,
                    complete: true,
                    minigoal: habit.minigoal,
                    reminder: habit.reminder,
                    todaytime: stopwatch.elapsed.inSeconds,
                    totaldays: habit.totaldays + 1,
                    totaltime: habit.totaltime + stopwatch.elapsed.inSeconds,
                    type: habit.type,
                    donedates: habit.donedates + [date],
                  ),
                );
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 1.7,
                height: 56,
                decoration: BoxDecoration(
                  color: HexColor('#5353FF'),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Stop & Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
