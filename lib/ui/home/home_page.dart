import 'package:fcm_app_tester/extension/build_context_extension.dart';
import 'package:fcm_app_tester/ui/console/console_page.dart';
import 'package:fcm_app_tester/ui/widget/contributor_info.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.appName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryFixed,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        centerTitle: false,
      ),
      body: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          ContributorInfo(),
          Expanded(
            child: ConsolePage(),
          ),
        ],
      ),
    );
  }
}
