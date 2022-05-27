import 'package:hive/hive.dart';

part 'myhabitmodel.g.dart';

@HiveType(typeId: 0)
class MyHabitModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String type;
  @HiveField(2)
  bool complete;
  @HiveField(3)
  String reminder;
  @HiveField(4)
  int totaldays;
  @HiveField(5)
  int totaltime;
  @HiveField(6)
  int todaytime;
  @HiveField(7)
  int avgtime;
  @HiveField(8)
  int minigoal;
  @HiveField(9)
  List<String> donedates;
  @HiveField(10)
  List<int> everydaytime;
  @HiveField(11)
  String trackway;
  @HiveField(12)
  int streak;
  @HiveField(13)
  bool skipped;

  MyHabitModel({
    this.name,
    this.type,
    this.complete,
    this.reminder,
    this.totaldays,
    this.totaltime,
    this.todaytime,
    this.avgtime,
    this.minigoal,
    this.donedates,
    this.everydaytime,
    this.trackway,
    this.streak,
    this.skipped,
  });
}
