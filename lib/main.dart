import 'package:fcm_app_tester/theme/theme.dart';
import 'package:fcm_app_tester/ui/home/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';

void main() async {
  // Wait for widget binding
  WidgetsFlutterBinding.ensureInitialized();

  // Setup logger
  _setupLogging();

  runApp(MaterialApp(
    title: 'Firebase Messaging Console',
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: AppTheme.theme,
    darkTheme: AppTheme.darkTheme,
    home: const HomePage(),
  ));
}

_setupLogging() {
  Logger.root.level = kDebugMode ? Level.WARNING : Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });
}
