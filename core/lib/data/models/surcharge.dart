class TimeFrame {
  final List<WeekDays>? weekDays;
  final TimeRange? timeRange;
  const TimeFrame({this.weekDays, this.timeRange});
  TimeFrame copyWith({List<WeekDays>? weekDays, TimeRange? timeRange}) {
    return TimeFrame(
        weekDays: weekDays ?? this.weekDays,
        timeRange: timeRange ?? this.timeRange);
  }

  Map<String, Object?> toJson() {
    return {
      'weekDays':
          weekDays?.map<Map<String, dynamic>>((data) => data.toJson()).toList(),
      'timeRange': timeRange?.toJson()
    };
  }

  static TimeFrame fromJson(Map<String, Object?> json) {
    return TimeFrame(
        weekDays: json['weekDays'] == null
            ? null
            : (json['weekDays'] as List)
                .map<WeekDays>(
                    (data) => WeekDays.fromJson(data as Map<String, Object?>))
                .toList(),
        timeRange: json['timeRange'] == null
            ? null
            : TimeRange.fromJson(json['timeRange'] as Map<String, Object?>));
  }

  @override
  String toString() {
    return '''timeFrame(
                weekDays:${weekDays.toString()},
timeRange:${timeRange.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is TimeFrame &&
        other.runtimeType == runtimeType &&
        other.weekDays == weekDays &&
        other.timeRange == timeRange;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, weekDays, timeRange);
  }
}

class TimeRange {
  final String? startTimeRange;
  final String? endTimeRange;
  const TimeRange({this.startTimeRange, this.endTimeRange});
  TimeRange copyWith({String? startTimeRange, String? endTimeRange}) {
    return TimeRange(
        startTimeRange: startTimeRange ?? this.startTimeRange,
        endTimeRange: endTimeRange ?? this.endTimeRange);
  }

  Map<String, Object?> toJson() {
    return {'startTimeRange': startTimeRange, 'endTimeRange': endTimeRange};
  }

  static TimeRange fromJson(Map<String, Object?> json) {
    return TimeRange(
        startTimeRange: json['startTimeRange'] == null
            ? null
            : json['startTimeRange'] as String,
        endTimeRange: json['endTimeRange'] == null
            ? null
            : json['endTimeRange'] as String);
  }

  @override
  String toString() {
    return '''TimeRange(
                startTimeRange:$startTimeRange,
endTimeRange:$endTimeRange
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is TimeRange &&
        other.runtimeType == runtimeType &&
        other.startTimeRange == startTimeRange &&
        other.endTimeRange == endTimeRange;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, startTimeRange, endTimeRange);
  }
}

class WeekDays {
  final int? id;
  final String? weekDay;
  final bool? isSelected;
  const WeekDays({this.id, this.weekDay, this.isSelected});
  WeekDays copyWith({int? id, String? weekDay, bool? isSelected}) {
    return WeekDays(
        id: id ?? this.id,
        weekDay: weekDay ?? this.weekDay,
        isSelected: isSelected ?? this.isSelected);
  }

  Map<String, Object?> toJson() {
    return {'id': id, 'weekDay': weekDay, 'isSelected': isSelected};
  }

  static WeekDays fromJson(Map<String, Object?> json) {
    return WeekDays(
        id: json['id'] == null ? null : json['id'] as int,
        weekDay: json['weekDay'] == null ? null : json['weekDay'] as String,
        isSelected:
            json['isSelected'] == null ? null : json['isSelected'] as bool);
  }

  @override
  String toString() {
    return '''WeekDays(
                id:$id,
weekDay:$weekDay,
isSelected:$isSelected
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is WeekDays &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.weekDay == weekDay &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, weekDay, isSelected);
  }
}
