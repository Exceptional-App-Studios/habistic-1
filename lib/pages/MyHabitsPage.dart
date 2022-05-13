import 'dart:io';
import 'dart:typed_data';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habisitic/models/myhabitmodel.dart';
import 'package:habisitic/pages/CreateHabit.dart';
import 'package:habisitic/pages/Edithabit.dart';
import 'package:habisitic/pages/LevelsScreen.dart';
import 'package:habisitic/pages/TimerPage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import '../main.dart';
import '../models/Database.dart';

// const String dataBoxName = "data";

class MyHabitsPage extends StatefulWidget {
  const MyHabitsPage({
    Key key,
  }) : super(key: key);

  @override
  State<MyHabitsPage> createState() => _MyHabitsPageState();
}

enum DataFilter { ALL, COMPLETED, PROGRESS }

class _MyHabitsPageState extends State<MyHabitsPage> {
  Box<MyHabitModel> dataBox;

  String date = DateFormat("dd-MM-yyy").format(DateTime.now());
  String previousdate = DateFormat('dd-MM-yyy')
      .format(DateTime.now().subtract(Duration(days: 1)));
  @override
  void initState() {
    dataBox = Hive.box<MyHabitModel>(dataBoxName);
    super.initState();
    Practice.checkPractice();
  }

  DataFilter filter = DataFilter.ALL;
  int totaldays =
      Database.prefs.getInt('totaldays', defaultValue: 0).getValue();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('#5353FF'),
        child: Icon(
          Icons.add,
          size: 27,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateHabitPage(),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LevelScreen(),
                        ));
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      PreferenceBuilder(
                        preference:
                            Database.prefs.getInt('totaldays', defaultValue: 0),
                        builder: (context, value) {
                          return CircularPercentIndicator(
                            animation: true,
                            startAngle: 180,
                            radius: 60,
                            backgroundColor: Colors.transparent,
                            progressColor: totaldays < 14
                                ? HexColor('#FFBE29')
                                : HexColor('#B100FF'),
                            percent: value / 7,
                            center: PreferenceBuilder(
                              preference: Database.prefs.getString(
                                  "profilephotopath",
                                  defaultValue: "none"),
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
                                      radius: 55,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: MemoryImage(
                                        Uint8List.fromList(
                                            File(value).readAsBytesSync()),
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: -3,
                        child: Container(
                          width: 51.91,
                          height: 21,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            gradient: totaldays < 7
                                ? LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      HexColor('#FFBE29'),
                                      HexColor('#D8A42F'),
                                    ],
                                  )
                                : LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      HexColor('#CE00FF'),
                                      HexColor('#AA00E8'),
                                    ],
                                  ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: PreferenceBuilder(
                            preference: Database.prefs
                                .getInt('totaldays', defaultValue: 0),
                            builder: (context, value) => Center(
                              child: Text(
                                '${value.toString()} 🔥',
                                style: GoogleFonts.openSans(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(
                  totaldays < 14
                      ? 'Track all habits for 7 days'
                      : 'Track all habits for 14 days',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    color: totaldays < 14
                        ? HexColor('#FFB100')
                        : HexColor('#B100FF'),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Habits',
                    style: GoogleFonts.openSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: HexColor('#C1C1C1'),
                    ),
                  ),
                  PreferenceBuilder(
                    preference: Database.prefs.getInt('done', defaultValue: 0),
                    builder: (context, value) => Text(
                      " ${value.toString()} / ${dataBox.length.toString() ?? 0}",
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#C1C1C1'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: dataBox.listenable(),
              builder: (context, Box<MyHabitModel> items, _) {
                List<int> keys;

                if (filter == DataFilter.ALL) {
                  keys = items.keys.cast<int>().toList();
                  // keys = items.keys
                  //     .cast<int>()
                  //     .where((key) => !items.getAt(key).complete)
                  //     .toList();
                }
                {
                  keys = items.keys
                      .cast<int>()
                      .where((key) => !items.get(key).complete)
                      .toList();
                }
                return ListView.separated(
                  separatorBuilder: (_, index) =>
                      Divider(color: Colors.transparent),
                  itemCount: keys.length ?? 0,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    final int key = keys[index];
                    final MyHabitModel data = items.get(key);
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditHabit(
                                        index: key,
                                        fromdone: false,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          data.name,
                                          style: GoogleFonts.openSans(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          data.reminder,
                                          style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#777777'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      data.totaldays.toString() + ' 🔥',
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                if (data.type == 'yes/no') {
                                  setState(() {
                                    dataBox.put(
                                      key,
                                      MyHabitModel(
                                        name: data.name,
                                        avgtime: data.avgtime,
                                        complete: true,
                                        minigoal: data.minigoal,
                                        reminder: data.reminder,
                                        todaytime: data.todaytime + 1,
                                        totaldays: data.totaldays + 1,
                                        totaltime: data.totaltime + 1,
                                        type: data.type,
                                        donedates: data.donedates + [date],
                                      ),
                                    );
                                  });
                                } else if (data.type == 'track') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => TrackProgress(
                                        habitModel: data, index: key),
                                  );
                                }
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                height: 45,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24.0,
                                      height: 24.0,
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: ValueListenableBuilder(
                  valueListenable: dataBox.listenable(),
                  builder: (context, Box<MyHabitModel> items, child) {
                    List<int> keys;

                    if (filter == DataFilter.COMPLETED) {
                      keys = items.keys
                          .cast<int>()
                          .where((key) => items.getAt(key).complete)
                          .toList();
                    } else {
                      keys = items.keys
                          .cast<int>()
                          .where((key) => items.get(key).complete)
                          .toList();
                    }
                    return ExpandablePanel(
                      theme: ExpandableThemeData(
                        // tapHeaderToExpand: true,
                        // collapseIcon: Icons.arrow_drop_up_sharp,
                        hasIcon: false,
                        // expandIcon: Icons.arrow_drop_down_sharp,
                        iconPadding: EdgeInsets.zero,
                        tapBodyToCollapse: true,
                        tapBodyToExpand: true,
                        useInkWell: false,
                        // iconPlacement: ExpandablePanelIconPlacement.left,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      ),
                      header: Center(
                        child: Container(
                          height: 40,
                          child: Text(
                            'Show Done (${keys.length ?? 0})',
                            style: GoogleFonts.openSans(
                              color: HexColor('#C1C1C1'),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      collapsed: Container(),
                      expanded: ListView.separated(
                        separatorBuilder: (_, index) =>
                            Divider(color: Colors.transparent),
                        itemCount: keys.length ?? 0,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (_, index) {
                          final int key = keys[index];
                          final MyHabitModel data = items.get(key);
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        // print(data.donedates);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditHabit(
                                              index: key,
                                              fromdone: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                data.name,
                                                style: GoogleFonts.openSans(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                data.type == 'yes/no'
                                                    ? "Marked as done"
                                                    : (data.todaytime < 60)
                                                        ? data.todaytime
                                                                .toString() +
                                                            " secs done today"
                                                        : (data.todaytime <
                                                                3600)
                                                            ? (data.todaytime /
                                                                        60)
                                                                    .toStringAsFixed(
                                                                        1) +
                                                                ' minutes done today'
                                                            : (data.todaytime /
                                                                        3600)
                                                                    .toStringAsFixed(
                                                                        1) +
                                                                " hrs done today",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: HexColor('#777777'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            data.totaldays.toString() + ' 🔥',
                                            style: GoogleFonts.openSans(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrackProgress extends StatefulWidget {
  final MyHabitModel habitModel;
  final int index;
  const TrackProgress({Key key, this.habitModel, this.index}) : super(key: key);

  @override
  State<TrackProgress> createState() => _TrackProgressState();
}

var habit;

class _TrackProgressState extends State<TrackProgress> {
  @override
  void initState() {
    habit = widget.habitModel;
    dataBox = Hive.box<MyHabitModel>(dataBoxName);
    _currentCount = dataBox.getAt(widget.index).minigoal ~/ 60;
    // trackController.text = track.toString();
    super.initState();
  }

  Box<MyHabitModel> dataBox;
  final TextEditingController trackController = new TextEditingController();
  String date = DateFormat("dd-MM-yyy").format(DateTime.now());

  // int track = habit.totaldays;

  Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Icon(
        icon,
        color: Colors.black,
        size: 34,
      ),
    );
  }

  int _currentCount;

  void _increment() {
    setState(() {
      _currentCount++;
      // _counterCallback(_currentCount);
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > 1) {
        _currentCount--;
        // _counterCallback(_currentCount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      // insetPadding: EdgeInsets.all(),
      // contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              habit.name,
              style: GoogleFonts.openSans(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Container(
                width: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _createIncrementDicrementButton(
                        Icons.remove, () => _dicrement()),
                    Text(
                      _currentCount.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 40,
                      ),
                    ),
                    _createIncrementDicrementButton(
                        Icons.add, () => _increment()),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Text(
                dataBox.getAt(widget.index).trackway,
                style: GoogleFonts.roboto(fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 10),
              child: GestureDetector(
                onTap: () async {
                  dataBox.put(
                    widget.index,
                    MyHabitModel(
                      name: habit.name,
                      avgtime: habit.avgtime,
                      complete: true,
                      minigoal: habit.minigoal,
                      reminder: habit.reminder,
                      todaytime: (_currentCount * 60),
                      totaldays: habit.totaldays + 1,
                      totaltime: habit.totaltime + _currentCount * 60,
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
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Save Progress',
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
            GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimerPage(
                      index: widget.index,
                      habits: habit,
                      duration: _currentCount,
                    ),
                  ),
                );
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
                    'Start Timer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Skip',
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
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
