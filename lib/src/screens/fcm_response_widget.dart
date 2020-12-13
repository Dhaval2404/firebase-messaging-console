
import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';

class FCMResponseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var json = <String, dynamic>{
      'multicast_id': -1,
      'failure': 2,
      'canonical_ids': 0,
      'results': [
        {
          'error': 'InvalidRegistration',
        },
        {
          'message_id': 636378436483684,
        }
      ]
    };

    var jsonText = prettyJson(json, indent: 8);
    print(jsonText);
    return Container(
      padding: EdgeInsets.all(24),
      child: Text(
        jsonText,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
