import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../util/navigation_util.dart';

class ContributorWidget extends StatelessWidget {
  final String _profileLink = "https://github.com/Dhaval2404";

  final String _contributionLink = "https://github.com/Dhaval2404/"
      "firebase-messaging-tester/network/dependencies";

  final _linkStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          text: 'contribution_built_with'.tr(),
          style: Theme.of(context).textTheme.bodyText2,
          children: <TextSpan>[
            TextSpan(
              text: 'contribution_love'.tr(),
              style: TextStyle(color: Colors.red),
            ),
            TextSpan(text: 'contribution_by'.tr()),
            TextSpan(
              text: 'contribution_dhaval_patel'.tr(),
              style: _linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  NavigationUtil.launchURL(_profileLink);
                },
            ),
            TextSpan(text: 'contribution_and'.tr()),
            TextSpan(
              text: 'contribution_contributors'.tr(),
              style: _linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  NavigationUtil.launchURL(_contributionLink);
                },
            ),
          ],
      ),
      ),
    );
  }
}
