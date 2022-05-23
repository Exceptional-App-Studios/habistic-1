import 'dart:convert';
import 'package:flutter/foundation.dart';

class HappinessHabitList {
  final List<HappinessHabits> happiness;
  HappinessHabitList({
    this.happiness,
  });

  HappinessHabitList copyWith({
    List<HappinessHabits> happiness,
  }) {
    return HappinessHabitList(
      happiness: happiness ?? this.happiness,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'happiness': happiness.map((x) => x.toMap()).toList(),
    };
  }

  factory HappinessHabitList.fromMap(Map<String, dynamic> map) {
    return HappinessHabitList(
      happiness: List<HappinessHabits>.from(
          map['happiness']?.map((x) => HappinessHabits.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HappinessHabitList.fromJson(String source) =>
      HappinessHabitList.fromMap(json.decode(source));

  @override
  String toString() => 'HappinessHabitList(happiness: $happiness)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HappinessHabitList &&
        listEquals(other.happiness, happiness);
  }

  @override
  int get hashCode => happiness.hashCode;
}

class HappinessHabits {
  final int id;
  final String habitname;
  final String benefit1;
  final String benefit2;
  final String benefit3;
  final String benefit4;
  final String benefit5;
  final int minigoal;
  final String trackway;
  final String type;
  final String image;

  HappinessHabits({
    this.id,
    this.habitname,
    this.benefit1,
    this.benefit2,
    this.benefit3,
    this.benefit4,
    this.benefit5,
    this.minigoal,
    this.trackway,
    this.type,
    this.image,
  });

  HappinessHabits copyWith({
    int id,
    String habitname,
    String benefit1,
    String benefit2,
    String benefit3,
    String benefit4,
    String benefit5,
    int minigoal,
    String trackway,
    String type,
    String image,
  }) {
    return HappinessHabits(
      id: id ?? this.id,
      habitname: habitname ?? this.habitname,
      benefit1: benefit1 ?? this.benefit1,
      benefit2: benefit2 ?? this.benefit2,
      benefit3: benefit3 ?? this.benefit3,
      benefit4: benefit4 ?? this.benefit4,
      benefit5: benefit5 ?? this.benefit5,
      minigoal: minigoal ?? this.minigoal,
      trackway: trackway ?? this.trackway,
      type: type ?? this.type,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'habitname': habitname,
      'benefit1': benefit1,
      'benefit2': benefit2,
      'benefit3': benefit3,
      'benefit4': benefit4,
      'benefit5': benefit5,
      'minigoal': minigoal,
      'trackway': trackway,
      'type': type,
      'image': image,
    };
  }

  factory HappinessHabits.fromMap(Map<String, dynamic> map) {
    return HappinessHabits(
      id: map['id']?.toInt() ?? 0,
      habitname: map['habitname'] ?? '',
      benefit1: map['benefit1'] ?? '',
      benefit2: map['benefit2'] ?? '',
      benefit3: map['benefit3'] ?? '',
      benefit4: map['benefit4'] ?? '',
      benefit5: map['benefit5'] ?? '',
      minigoal: map['minigoal']?.toInt() ?? 0,
      trackway: map['trackway'] ?? '',
      type: map['type'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HappinessHabits.fromJson(String source) =>
      HappinessHabits.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HappinessHabits(id: $id, habitname: $habitname, benefit1: $benefit1, benefit2: $benefit2, benefit3: $benefit3, benefit4: $benefit4, benefit5: $benefit5, minigoal: $minigoal, trackway: $trackway, type: $type, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HappinessHabits &&
        other.id == id &&
        other.habitname == habitname &&
        other.benefit1 == benefit1 &&
        other.benefit2 == benefit2 &&
        other.benefit3 == benefit3 &&
        other.benefit4 == benefit4 &&
        other.benefit5 == benefit5 &&
        other.minigoal == minigoal &&
        other.trackway == trackway &&
        other.type == type &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        habitname.hashCode ^
        benefit1.hashCode ^
        benefit2.hashCode ^
        benefit3.hashCode ^
        benefit4.hashCode ^
        benefit5.hashCode ^
        minigoal.hashCode ^
        trackway.hashCode ^
        type.hashCode ^
        image.hashCode;
  }
}
