import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habisitic/main.dart';
import 'package:habisitic/models/myhabitmodel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  Box<MyHabitModel> dataBox;

  @override
  void initState() {
    dataBox = Hive.box<MyHabitModel>(dataBoxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 60),
            child: Text(
              'My Progress',
              style: GoogleFonts.openSans(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            color: HexColor('#C1C1C1'),
          ),
          ValueListenableBuilder(
            valueListenable: dataBox.listenable(),
            builder: (context, Box<MyHabitModel> items, _) {
              return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (_, index) => Divider(
                  color: HexColor('#C1C1C1'),
                ),
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final MyHabitModel data = items.getAt(index);
                  return Container(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Row(
                            children: [
                              Text(
                                data.name,
                                style: GoogleFonts.openSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "(${data.totaldays.toString()} days)",
                                style: GoogleFonts.openSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 42.0, right: 42, top: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  dataBox.getAt(index).type == "yes/no"
                                      ? Text(
                                          dataBox
                                              .getAt(index)
                                              .todaytime
                                              .toString(),
                                          style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: HexColor('#777777'),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      : Text(
                                          dataBox.getAt(index).todaytime < 60
                                              ? dataBox
                                                  .getAt(index)
                                                  .todaytime
                                                  .toString()
                                              : dataBox.getAt(index).todaytime <
                                                      3600
                                                  ? (dataBox
                                                              .getAt(index)
                                                              .todaytime /
                                                          60)
                                                      .toStringAsFixed(0)
                                                  : (dataBox
                                                              .getAt(index)
                                                              .todaytime /
                                                          60)
                                                      .toStringAsFixed(0),
                                          style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: HexColor('#777777'),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                  Text(
                                    dataBox.getAt(index).type == "yes/no"
                                        ? 'Yes/Done'
                                        : 'Today',
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      color: HexColor('#777777'),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ((dataBox.getAt(index).totaldays +
                                                  dataBox
                                                      .getAt(index)
                                                      .todaytime) /
                                              2)
                                          .isNaN
                                      ? Text('0')
                                      : Text(
                                          ((dataBox.getAt(index).totaldays /
                                                      60 +
                                                  dataBox
                                                          .getAt(index)
                                                          .todaytime /
                                                      60))
                                              .toStringAsFixed(1),
                                          style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                  Text(
                                    'Daily Avg.',
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    dataBox.getAt(index).totaltime < 60
                                        ? dataBox
                                            .getAt(index)
                                            .totaltime
                                            .toString()
                                        : dataBox.getAt(index).totaltime < 3600
                                            ? (dataBox.getAt(index).totaltime /
                                                    60)
                                                .toStringAsFixed(0)
                                            : (dataBox.getAt(index).totaltime /
                                                    60)
                                                .toStringAsFixed(0),
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      color: HexColor('#777777'),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'Total',
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      color: HexColor('#777777'),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
