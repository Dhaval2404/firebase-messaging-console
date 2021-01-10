import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
          text: 'Built with',
          style: TextStyle(color: Colors.grey[800]),
          children: <TextSpan>[
            TextSpan(
              text: ' ❤ ',
              style: TextStyle(color: Colors.red),
            ),
            TextSpan(text: ' by '),
            TextSpan(
              text: 'Dhaval Patel',
              style: _linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  NavigationUtil.launchURL(_profileLink);
                },
            ),
            TextSpan(text: ' and '),
            TextSpan(
              text: 'Contributors',
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
