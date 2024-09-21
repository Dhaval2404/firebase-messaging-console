import 'package:fcm_app_tester/constant/app_constant.dart';
import 'package:fcm_app_tester/extension/build_context_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContributorInfo extends StatelessWidget {
  const ContributorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final linkStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          decoration: TextDecoration.underline,
        );

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          text: context.l10n.contributionInfo_builtWith,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
          children: <TextSpan>[
            TextSpan(
              text: context.l10n.contributionInfo_love,
              style: const TextStyle(color: Colors.red),
            ),
            TextSpan(text: context.l10n.contributionInfo_by),
            TextSpan(
              text: context.l10n.contributionInfo_dhavalPatel,
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchInBrowser(AppConstant.githubProfileLink);
                },
            ),
            TextSpan(text: context.l10n.contributionInfo_and),
            TextSpan(
              text: context.l10n.contributionInfo_contributors,
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchInBrowser(AppConstant.githubRepoURL);
                },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
