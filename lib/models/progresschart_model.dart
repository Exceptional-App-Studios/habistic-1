import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ProgressData {
  final String date;
  final num minutes;

  ProgressData({
    @required this.date,
    @required this.minutes,
  });
}
