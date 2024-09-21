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

    final defaultStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        );
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          text: 'Built with',
          style: defaultStyle,
          children: <TextSpan>[
            const TextSpan(
              text: ' ❤ ',
              style: TextStyle(color: Colors.red),
            ),
            const TextSpan(text: ' by '),
            TextSpan(
              text: 'Dhaval Patel',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchInBrowser("https://github.com/Dhaval2404");
                },
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Contributors',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchInBrowser(
                      "https://github.com/Dhaval2404/firebase-messaging-tester");
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
