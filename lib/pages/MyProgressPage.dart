import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habisitic/main.dart';
import 'package:habisitic/models/myhabitmodel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:hive_flutter/hive_flutter.dart';

import '../models/progresschart_model.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  Box<MyHabitModel> dataBox;
  List<String> data1;
  List<String> everydaytime;

  @override
  void initState() {
    dataBox = Hive.box<MyHabitModel>(dataBoxName);
    for (var i = 0; i < dataBox.length; i++) {
      data1 = dataBox.getAt(i).donedates;
      print(data1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 7),
              child: Text(
                'My Progress',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Track all your Progress from\none place',
                style: GoogleFonts.openSans(
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
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
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (_, index) => Divider(
                    color: HexColor('#C1C1C1'),
                  ),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final MyHabitModel data = items.getAt(index);
                    List<String> donedates = data.donedates;

                    List<charts.Series<MyHabitModel, String>> series = [
                      charts.Series(
                        id: "Subscribers",
                        data: dataBox.values.toList(),
                        domainFn: (MyHabitModel series, _) =>
                            donedates.toString(),
                        measureFn: (MyHabitModel series, _) =>
                            dataBox.getAt(index).minigoal,
                        seriesColor: charts.Color(r: 83, g: 83, b: 255),
                      )
                    ];
                    return Column(
                      children: [
                        Container(
                          // height: 100,
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
                              Container(
                                height: 200,
                                child: charts.BarChart(
                                  series,
                                  animate: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 42.0, right: 42, top: 35),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                dataBox.getAt(index).todaytime <
                                                        60
                                                    ? dataBox
                                                            .getAt(index)
                                                            .todaytime
                                                            .toString() +
                                                        ' secs'
                                                    : dataBox
                                                                .getAt(index)
                                                                .todaytime <
                                                            3600
                                                        ? (dataBox
                                                                        .getAt(
                                                                            index)
                                                                        .todaytime /
                                                                    60)
                                                                .toStringAsFixed(
                                                                    0) +
                                                            ' mins'
                                                        : (dataBox
                                                                    .getAt(
                                                                        index)
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
                                        ((dataBox.getAt(index).totaltime +
                                                        dataBox
                                                            .getAt(index)
                                                            .todaytime) /
                                                    2)
                                                .isNaN
                                            ? Text('0')
                                            : Text(
                                                ((dataBox
                                                                .getAt(index)
                                                                .todaytime /
                                                            60 +
                                                        dataBox
                                                                .getAt(index)
                                                                .totaldays /
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
                                        dataBox.getAt(index).type == "yes/no"
                                            ? Text(
                                                dataBox
                                                    .getAt(index)
                                                    .totaldays
                                                    .toString(),
                                                style: GoogleFonts.openSans(
                                                  fontSize: 14,
                                                  color: HexColor('#777777'),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            : Text(
                                                dataBox.getAt(index).totaltime <
                                                        60
                                                    ? dataBox
                                                            .getAt(index)
                                                            .totaltime
                                                            .toString() +
                                                        ' secs'
                                                    : dataBox
                                                                .getAt(index)
                                                                .totaltime <
                                                            3600
                                                        ? (dataBox
                                                                        .getAt(
                                                                            index)
                                                                        .totaltime /
                                                                    60)
                                                                .toStringAsFixed(
                                                                    0) +
                                                            ' mins'
                                                        : (dataBox
                                                                    .getAt(
                                                                        index)
                                                                    .totaltime /
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
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
