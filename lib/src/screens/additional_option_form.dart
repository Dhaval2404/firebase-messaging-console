import 'package:firebase_messaging_tester/res/theme.dart';
import 'package:firebase_messaging_tester/src/data/fcm_duration.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_text_form_field.dart';

class AdditionalOptionForm extends StatefulWidget {
  @override
  _AdditionalOptionFormState createState() => _AdditionalOptionFormState();
}

class _AdditionalOptionFormState extends State<AdditionalOptionForm> {
  FCMDuration _duration = FCMDuration.weeks;
  int _durationValue = 0;
  String _sound = "Enabled";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Theme(
      data: theme,
      child: ExpansionTile(
        initiallyExpanded: false,
        expandedAlignment: Alignment.topLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: EdgeInsets.zero,
        title: Text("Additional Option", style: AppTheme.tileTitle(context),),
        children: _option(),
      ),
    );
  }

  List<Widget> _option() {
    return <Widget>[
      CustomTextFormField(
        labelText: "Android Notification Channel",
        hintText: "",
      ),
      SizedBox(height: 18),
      Align(
        alignment: Alignment.centerLeft,
        child: Text("Sound",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.normal)),
      ),
      SizedBox(height: 8),
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 180,
          child: DropdownButtonFormField<String>(
            value: _sound,
            elevation: 16,
            decoration: const InputDecoration(
              border: const OutlineInputBorder(),
            ),
            onChanged: (String newValue) {
              setState(() {
                _sound = newValue;
              });
            },
            items: ["Enabled", "Disabled"].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
      SizedBox(height: 18),
      Align(
        alignment: Alignment.centerLeft,
        child: Text("Expires",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.normal)),
      ),
      SizedBox(height: 8),
      Container(
        width: 372,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: DropdownButtonFormField<int>(
                value: _durationValue,
                elevation: 16,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                ),
                onChanged: (int newValue) {
                  setState(() {
                    _durationValue = newValue;
                  });
                },
                items: _duration.range.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: 12),
            Flexible(
              flex: 1,
              child: DropdownButtonFormField<FCMDuration>(
                value: _duration,
                elevation: 16,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                ),
                onChanged: (FCMDuration newValue) {
                  setState(() {
                    if(newValue.maxValue<_durationValue){
                      _durationValue = newValue.maxValue;
                    }
                    _duration = newValue;
                  });
                },
                items: FCMDuration.values
                    .map<DropdownMenuItem<FCMDuration>>((FCMDuration value) {
                  return DropdownMenuItem<FCMDuration>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
