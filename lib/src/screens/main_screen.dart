
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'additional_option_form.dart';
import 'custom_data_form.dart';
import 'notification_form.dart';
import 'target_form.dart';
import 'widgets/indicator_widget.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase FCM Tester"),
      ),
      body: _body()/*Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _body()
          Flexible(flex: 1, child: _body()),
          Container(
            width: 1,
            height: double.infinity,
            color: Colors.grey,
          ),
          Flexible(
            flex: 1,
            child: FCMResponseWidget(),
          ),
        ],
      ),*/
    );
  }

  Widget _body() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(12),
      children: [
        TimelineTile(
          axis: TimelineAxis.vertical,
          isFirst: true,
          indicatorStyle: IndicatorStyle(
            width: 40,
            height: 40,
            indicator: IndicatorWidget(number: '1'),
            drawGap: true,
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: NotificationForm(),
          ),
        ),
        TimelineTile(
          axis: TimelineAxis.vertical,
          isFirst: false,
          isLast: false,
          indicatorStyle: IndicatorStyle(
            width: 40,
            height: 40,
            indicator: IndicatorWidget(number: '2'),
            drawGap: true,
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: TargetForm(),
          ),
        ),
        TimelineTile(
          axis: TimelineAxis.vertical,
          isFirst: false,
          isLast: false,
          indicatorStyle: IndicatorStyle(
            width: 40,
            height: 40,
            indicator: IndicatorWidget(number: '3'),
            drawGap: true,
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: CustomForm(),
          ),
        ),
        TimelineTile(
          axis: TimelineAxis.vertical,
          isFirst: false,
          isLast: true,
          indicatorStyle: IndicatorStyle(
            width: 40,
            height: 40,
            indicator: IndicatorWidget(number: '4'),
            drawGap: true,
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: AdditionalOptionForm(),
          ),
        ),
        SizedBox(height: 18),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(left: 16),
          child: RaisedButton(
            onPressed: () {},
            child: Text("Send Notification"),
          ),
        ),
        SizedBox(height: 18),
      ],
    );
  }
}
