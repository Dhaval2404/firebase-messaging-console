enum FCMDuration {
  weeks,
  days,
  hours,
  minutes,
}

extension FCMDurationExtension on FCMDuration {
  int get maxValue {
    switch (this) {
      case FCMDuration.weeks:
        return 4;
      case FCMDuration.days:
        return 7;
      case FCMDuration.hours:
        return 24;
      case FCMDuration.minutes:
        return 60;
      default:
        return 4;
    }
  }

  String get name {
    switch (this) {
      case FCMDuration.weeks:
        return "Weeks";
      case FCMDuration.days:
        return "Days";
      case FCMDuration.hours:
        return "Hours";
      case FCMDuration.minutes:
        return "Minutes";
      default:
        return "Weeks";
    }
  }

  List<int> get range {
    var max = this.maxValue;
    var list = <int>[];
    for (var i = 0; i <= max; i++) {
      list.add(i);
    }
    return list;
  }

  Duration getDuration(int value) {
    switch (this) {
      case FCMDuration.weeks:
        return Duration(days: 7 * value);
      case FCMDuration.days:
        return Duration(days: value);
      case FCMDuration.hours:
        return Duration(hours: value);
      case FCMDuration.minutes:
        return Duration(minutes: value);
      default:
        return Duration(minutes: value);
    }
  }

}
