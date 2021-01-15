import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseManager {
  FirebaseAnalytics analytics = FirebaseAnalytics();

  void logViewEvent(String event) {
    analytics.logEvent(
      name: 'view_item',
      parameters: {"content_type": event},
    );
  }

  void logSelectContentEvent(String event) {
    analytics.logEvent(
      name: 'select_content',
      parameters: {"content_type": event},
    );
  }

  void logDarkModeEvent({bool enabled = false}) {
    analytics.logEvent(
      name: 'dark_mode',
      parameters: {"status": enabled},
    );
  }
}
