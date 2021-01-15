import 'package:universal_platform/universal_platform.dart';
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
    if (UniversalPlatform.isAndroid) {
      return "android";
    } else if (UniversalPlatform.isIOS) {
      return "ios";
    } else if (UniversalPlatform.isWindows) {
      return "windows";
    } else if (UniversalPlatform.isMacOS) {
      return "mac";
    } else if (UniversalPlatform.isLinux) {
      return "linux";
    } else {
      return "web";
    }
  }
}
