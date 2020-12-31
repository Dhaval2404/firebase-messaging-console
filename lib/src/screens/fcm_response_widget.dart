import 'package:firebase_messaging_tester/res/theme.dart';
import 'package:firebase_messaging_tester/src/data/model/fcm_response.dart';
import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';

class FCMResponseWidget extends StatelessWidget {
  final FCMResponse response;
  final int status;

  const FCMResponseWidget({this.response, this.status = 200});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(
      dividerColor: Colors.transparent,
    );
    return Theme(
      data: theme,
      child: Container(
        color: Colors.grey[200],
        child: ExpansionTile(
          initiallyExpanded: true,
          expandedAlignment: Alignment.topLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: EdgeInsets.zero,
          title: Text(
            "Response",
            style: AppTheme.tileTitle(context),
          ),
          children: [_body(context)],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    var jsonText = "(waiting to send request)";
    if (response != null) {
      jsonText = prettyJson(response.toJson(), indent: 8);
    }

    print(jsonText);
    return Container(
      width: double.infinity,
      color: Colors.grey[100],
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: RichText(
              text: TextSpan(
                text: "Status\t\t",
                style: Theme.of(context).textTheme.subtitle2,
                children: _statusCodes(context),
              ),
            ),
          ),
          Divider(),
          Text(
            jsonText,
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }

  List<InlineSpan> _statusCodes(BuildContext context) {
    var spans = <InlineSpan>[];
    if (status != null) {
      spans.add(
        TextSpan(
          text: status.toString(),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold, color: _statusColor()),
        ),
      );
    }
    return spans;
  }

  Color _statusColor() {
    if (status == null || status <= 199) {
      return Colors.green;
    } else if (status <= 299) {
      return Colors.green;
    } else if (status <= 399) {
      return Colors.orange;
    } else if (status <= 499) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

}
