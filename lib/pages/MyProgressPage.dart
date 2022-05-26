import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habisitic/main.dart';
import 'package:habisitic/models/myhabitmodel.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  Box<MyHabitModel> dataBox;
  List<String> data1;
  List<String> everydaytime;
  List<_SalesData> chartdata = [];

  @override
  void initState() {
    dataBox = Hive.box<MyHabitModel>(dataBoxName);
    for (var i = 0; i < dataBox.length; i++) {
      data1 = dataBox.getAt(i).donedates;
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
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Text(
                'My Progress',
                style: GoogleFonts.openSans(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Text(
                'Last 14 days 🔽',
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  color: HexColor('777777'),
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
                    List<_SalesData> chartdata = [];

                    for (int i = 0; i < data.everydaytime.length; i++) {
                      chartdata.add(
                        _SalesData(
                          data.donedates.indexOf(data.donedates[i]),
                          data.type == 'yes/no'
                              ? data.everydaytime[i]
                              : data.everydaytime[i] < 60
                                  ? data.everydaytime[i]
                                  : data.everydaytime[i] < 3600
                                      ? (data.everydaytime[i] ~/ 60).toInt()
                                      : data.everydaytime[i] / 3600.toInt(),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        Container(
                          // height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      data.name,
                                      style: GoogleFonts.openSans(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 6),
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
                                padding: EdgeInsets.only(top: 4),
                                height: 160,
                                child: SfCartesianChart(
                                  margin: EdgeInsets.all(0),
                                  plotAreaBackgroundColor: Colors.white,
                                  plotAreaBorderColor: Colors.transparent,
                                  isTransposed: true,
                                  primaryYAxis: NumericAxis(
                                    isVisible: false,
                                    decimalPlaces: 0,
                                    labelIntersectAction:
                                        AxisLabelIntersectAction.none,
                                    rangePadding: ChartRangePadding.auto,
                                    interval: 1,
                                  ),
                                  primaryXAxis: NumericAxis(
                                    maximumLabels: 14,
                                    isVisible: true,
                                    decimalPlaces: 0,
                                    labelAlignment: LabelAlignment.start,
                                    minimum: -1,
                                    maximum: 14,
                                    interval: 1,
                                    borderColor: Colors.black,
                                    labelStyle:
                                        TextStyle(color: Colors.transparent),
                                    axisLine: AxisLine(width: 1),
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                    majorTickLines:
                                        const MajorTickLines(size: 0),
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                  ),
                                  borderColor: Colors.transparent,
                                  series: <BarSeries>[
                                    BarSeries<_SalesData, int>(
                                      dataSource: chartdata,
                                      xValueMapper: (_SalesData data, _) =>
                                          data.date,
                                      yValueMapper: (_SalesData data, _) =>
                                          data.time.toInt(),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.zero,
                                        bottomRight: Radius.zero,
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      sortingOrder: SortingOrder.ascending,
                                      width: 0.3,
                                      color: HexColor('#5353FF'),
                                      dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                        textStyle: TextStyle(
                                          fontSize: 10,
                                          color: HexColor('5353FF'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 30, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: 88, left: 85),
                                      child: Column(
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

class _SalesData {
  _SalesData(this.date, this.time);

  final int date;
  final int time;
}
