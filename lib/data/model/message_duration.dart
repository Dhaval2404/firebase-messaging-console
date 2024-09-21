enum MessageDuration {
  weeks,
  days,
  hours,
  minutes,
}

extension MessageDurationExtension on MessageDuration {
  int get maxValue {
    switch (this) {
      case MessageDuration.weeks:
        return 4;
      case MessageDuration.days:
        return 7;
      case MessageDuration.hours:
        return 24;
      case MessageDuration.minutes:
        return 60;
      default:
        return 4;
    }
  }

  String get name {
    switch (this) {
      case MessageDuration.weeks:
        return "Weeks";
      case MessageDuration.days:
        return "Days";
      case MessageDuration.hours:
        return "Hours";
      case MessageDuration.minutes:
        return "Minutes";
      default:
        return "Weeks";
    }
  }

  List<int> get range {
    var max = maxValue;
    var list = <int>[];
    for (var i = 0; i <= max; i++) {
      list.add(i);
    }
    return list;
  }

  Duration getDuration(int value) {
    switch (this) {
      case MessageDuration.weeks:
        return Duration(days: 7 * value);
      case MessageDuration.days:
        return Duration(days: value);
      case MessageDuration.hours:
        return Duration(hours: value);
      case MessageDuration.minutes:
        return Duration(minutes: value);
      default:
        return Duration(minutes: value);
    }
  }
}
