import 'package:flutter/material.dart';
import 'package:tfg_front/src/model/week_day_enum.dart';

class DateCustom {
  WeekDayEnum? weekDay;
  String? start;
  String? end;

  DateCustom({
    this.weekDay,
    this.start,
    this.end,
  });

  factory DateCustom.empty() {
    return DateCustom(weekDay: WeekDayEnum.empty);
  }

  bool get isEmpty {
    return weekDay == WeekDayEnum.empty;
  }

  TimeOfDay get startTimeOfDay {
    final time = start?.split(':');
    return TimeOfDay(
      hour: int.tryParse(time?.first ?? '') ?? 0,
      minute: int.tryParse(time?.last ?? '') ?? 0,
    );
  }

  TimeOfDay get endTimeOfDay {
    final time = end?.split(':');
    return TimeOfDay(
      hour: int.tryParse(time?.first ?? '') ?? 0,
      minute: int.tryParse(time?.last ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weekDay': weekDay?.name,
      'start': start,
      'end': end,
    };
  }

  factory DateCustom.fromMap(Map<String, dynamic> map) {
    return DateCustom(
      weekDay: WeekDayEnum.fromString(map['weekDay'] as String? ?? ''),
      start: map['start'] as String? ?? '',
      end: map['end'] as String? ?? '',
    );
  }
}
