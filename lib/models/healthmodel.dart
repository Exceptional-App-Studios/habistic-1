import 'dart:convert';

import 'package:flutter/foundation.dart';

class HealthHabitList {
  final List<HealthHabits> health;
  HealthHabitList({
    this.health,
  });

  HealthHabitList copyWith({
    List<HealthHabits> health,
  }) {
    return HealthHabitList(
      health: health ?? this.health,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'health': health.map((x) => x.toMap()).toList(),
    };
  }

  factory HealthHabitList.fromMap(Map<String, dynamic> map) {
    return HealthHabitList(
      health: List<HealthHabits>.from(
          map['health']?.map((x) => HealthHabits.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthHabitList.fromJson(String source) =>
      HealthHabitList.fromMap(json.decode(source));

  @override
  String toString() => 'HealthHabitList(health: $health)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HealthHabitList && listEquals(other.health, health);
  }

  @override
  int get hashCode => health.hashCode;
}

class HealthHabits {
  final int id;
  final String habitname;
  final String benefit1;
  final String benefit2;
  final String benefit3;
  final String benefit4;
  final String benefit5;
  final int duration;
  final String type;
  final String image;

  HealthHabits({
    this.id,
    this.habitname,
    this.benefit1,
    this.benefit2,
    this.benefit3,
    this.benefit4,
    this.benefit5,
    this.duration,
    this.type,
    this.image,
  });

  HealthHabits copyWith({
    int id,
    String habitname,
    String benefit1,
    String benefit2,
    String benefit3,
    String benefit4,
    String benefit5,
    int duration,
    String type,
    String image,
  }) {
    return HealthHabits(
      id: id ?? this.id,
      habitname: habitname ?? this.habitname,
      benefit1: benefit1 ?? this.benefit1,
      benefit2: benefit2 ?? this.benefit2,
      benefit3: benefit3 ?? this.benefit3,
      benefit4: benefit4 ?? this.benefit4,
      benefit5: benefit5 ?? this.benefit5,
      duration: duration ?? this.duration,
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
      'duration': duration,
      'type': type,
      'image': image,
    };
  }

  factory HealthHabits.fromMap(Map<String, dynamic> map) {
    return HealthHabits(
      id: map['id']?.toInt() ?? 0,
      habitname: map['habitname'] ?? '',
      benefit1: map['benefit1'] ?? '',
      benefit2: map['benefit2'] ?? '',
      benefit3: map['benefit3'] ?? '',
      benefit4: map['benefit4'] ?? '',
      benefit5: map['benefit5'] ?? '',
      duration: map['duration']?.toInt() ?? 0,
      type: map['type'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthHabits.fromJson(String source) =>
      HealthHabits.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HealthHabits(id: $id, habitname: $habitname, benefit1: $benefit1, benefit2: $benefit2, benefit3: $benefit3, benefit4: $benefit4, benefit5: $benefit5, duraton: $duration, type: $type, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HealthHabits &&
        other.id == id &&
        other.habitname == habitname &&
        other.benefit1 == benefit1 &&
        other.benefit2 == benefit2 &&
        other.benefit3 == benefit3 &&
        other.benefit4 == benefit4 &&
        other.benefit5 == benefit5 &&
        other.duration == duration &&
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
        duration.hashCode ^
        type.hashCode ^
        image.hashCode;
  }
}
