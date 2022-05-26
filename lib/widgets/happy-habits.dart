import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habisitic/main.dart';
import 'package:habisitic/models/myhabitmodel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import '../models/happinessmodel.dart';
import '../services/notification_service.dart';

class HappyHabit extends StatefulWidget {
  const HappyHabit({Key key}) : super(key: key);

  @override
  State<HappyHabit> createState() => _HappyHabitState();
}

class _HappyHabitState extends State<HappyHabit> {
  List<HappinessHabits> happiness;
  Box<MyHabitModel> dataBox;

  @override
  void initState() {
    fetchHappiness();
    dataBox = Hive.box<MyHabitModel>(dataBoxName);
    super.initState();
  }

  fetchHappiness() async {
    final happinessJson = await rootBundle.loadString("assets/happiness.json");
    happiness = HappinessHabitList.fromJson(happinessJson).happiness;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20),
              child: Text(
                'Stay Happy and Keep Smiling 😊',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#777777'),
                ),
              ),
            ),
            happiness == null
                ? CircularProgressIndicator()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: happiness.length ?? null,
                    itemBuilder: (context, index) {
                      final happyhabit = happiness[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Card(
                          color: HexColor('6767FF'),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              width: 331,
                              height: 140,
                              decoration: BoxDecoration(
                                color: HexColor('#505BF6'),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            imageUrl: happyhabit.image,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 331,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: imageProvider,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4),
                                    BlendMode.srcOver,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14.0, top: 21),
                                    child: ExpandablePanel(
                                      header: Text(
                                        happyhabit.benefit1,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      collapsed: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '+3 benefits',
                                            style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      expanded: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.0),
                                            child: Text(
                                              '1. ${happyhabit.benefit2}',
                                              style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.0),
                                            child: Text(
                                              '2.${happyhabit.benefit3}',
                                              style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.0),
                                            child: Text(
                                              '3. ${happyhabit.benefit4}',
                                              style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      theme: ExpandableThemeData(
                                        tapHeaderToExpand: true,
                                        collapseIcon: Icons.arrow_drop_up_sharp,
                                        iconColor: Colors.white,
                                        hasIcon: true,
                                        expandIcon: Icons.arrow_drop_down_sharp,
                                        iconPadding: EdgeInsets.only(right: 5),
                                        tapBodyToCollapse: true,
                                        tapBodyToExpand: true,
                                        useInkWell: false,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 24,
                                        bottom: 14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          happyhabit.habitname,
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (dataBox.values.any((element) =>
                                                element.name ==
                                                happyhabit.habitname))
                                              Fluttertoast.showToast(
                                                  msg: 'Habit already exists');
                                            else
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      insetPadding:
                                                          EdgeInsets.zero,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(11),
                                                      ),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius: 60,
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            happyhabit.image),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          12.0),
                                                                  child: Text(
                                                                    happyhabit
                                                                        .habitname,
                                                                    style: GoogleFonts
                                                                        .roboto(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          27.0),
                                                                  child: Text(
                                                                    'Pick the best time:',
                                                                    style: GoogleFonts
                                                                        .roboto(
                                                                      fontSize:
                                                                          17,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 5,
                                                                      bottom:
                                                                          50),
                                                                  child:
                                                                      FlatButton(
                                                                    onPressed:
                                                                        () async {
                                                                      await _selectTime(
                                                                          context);

                                                                      await NotificationApi
                                                                          .showScheduledNotification(
                                                                        title:
                                                                            "Time to ${happyhabit.habitname}",
                                                                        body:
                                                                            'Become a better you',
                                                                        id: 12,
                                                                        time: Time(
                                                                            selectedTime.minute,
                                                                            selectedTime.hour),
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      " ${selectedTime.hour}:${selectedTime.minute} ${selectedTime.hour > 12 ? 'PM' : 'AM'} ",
                                                                      style: GoogleFonts
                                                                          .openSans(
                                                                        fontSize:
                                                                            21,
                                                                        color: HexColor(
                                                                            '#5353FF'),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    MyHabitModel
                                                                        data =
                                                                        MyHabitModel(
                                                                      trackway:
                                                                          happyhabit
                                                                              .trackway,
                                                                      name: happyhabit
                                                                          .habitname,
                                                                      complete:
                                                                          false,
                                                                      avgtime:
                                                                          0,
                                                                      reminder:
                                                                          "${selectedTime.hour}:${selectedTime.minute}",
                                                                      todaytime:
                                                                          0,
                                                                      totaldays:
                                                                          0,
                                                                      totaltime:
                                                                          0,
                                                                      type: happyhabit
                                                                          .type,
                                                                      minigoal:
                                                                          happyhabit
                                                                              .minigoal,
                                                                      donedates: [],
                                                                      everydaytime: [],
                                                                      streak: 0,
                                                                      skipped:
                                                                          false,
                                                                    );

                                                                    await dataBox
                                                                        .add(
                                                                            data);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        1.6,
                                                                    height: 56,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        '+Add to My Habits',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          15.0),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'Close',
                                                                      style: GoogleFonts
                                                                          .openSans(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontSize:
                                                                            17,
                                                                        color: HexColor(
                                                                            '#777777'),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
          ],
        ),
      ),
    );
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  _selectTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}
