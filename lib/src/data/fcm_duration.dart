import 'package:easy_localization/easy_localization.dart';

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
        return "duration_weeks".tr();
      case FCMDuration.days:
        return "duration_days".tr();
      case FCMDuration.hours:
        return "duration_hours".tr();
      case FCMDuration.minutes:
        return "duration_minutes".tr();
      default:
        return "duration_weeks".tr();
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
