import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseManager {
  FirebaseAnalytics analytics = FirebaseAnalytics();

  void logViewEvent(String event) {
    analytics.logEvent(
      name: 'view_item',
      parameters: {
        "content_type": event,
        "platform": _platform(),
      },
    );
  }

  void logSelectContentEvent(String event) {
    analytics.logEvent(
      name: 'select_content',
      parameters: {
        "content_type": event,
        "platform": _platform(),
      },
    );
  }

  void logDarkModeEvent({bool enabled = false}) {
    analytics.logEvent(
      name: 'dark_mode',
      parameters: {
        "status": enabled,
        "platform": _platform(),
      },
    );
  }

  String _platform() {
    if (Platform.isAndroid) {
      return "android";
    } else if (Platform.isIOS) {
      return "ios";
    } else if (Platform.isWindows) {
      return "windows_os";
    } else if (Platform.isMacOS) {
      return "mac_os";
    } else if (Platform.isLinux) {
      return "linux";
    } else {
      return "web";
    }
  }
}
