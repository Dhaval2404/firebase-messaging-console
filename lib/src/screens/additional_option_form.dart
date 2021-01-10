import 'package:flutter/material.dart';

import '../data/fcm_duration.dart';
import '../data/model/fcm_model.dart';
import 'widgets/custom_text_form_field.dart';

class AdditionalOptionForm extends StatefulWidget {
  final FCMModel fcmModel;

  const AdditionalOptionForm({Key key, this.fcmModel}) : super(key: key);

  @override
  AdditionalOptionFormState createState() => AdditionalOptionFormState();
}

class AdditionalOptionFormState extends State<AdditionalOptionForm> {
  FCMDuration _duration = FCMDuration.weeks;
  int _durationValue = 0;
  final _androidChannelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _androidChannelController.text = widget.fcmModel.androidChannel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _option(),
    );
  }

  List<Widget> _option() {
    return <Widget>[
      CustomTextFormField(
        labelText: "Android Notification Channel",
        hintText: "",
        controller: _androidChannelController,
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
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _durationValue = newValue;
                  });
                },
                items: _duration.range.map<DropdownMenuItem<int>>((value) {
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
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setState(() {
                    if (newValue.maxValue < _durationValue) {
                      _durationValue = newValue.maxValue;
                    }
                    _duration = newValue;
                  });
                },
                items: FCMDuration.values
                    .map<DropdownMenuItem<FCMDuration>>((value) {
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

  bool validate() {
    save();
    return true;
  }

  void save() {
    var fcmModel = widget.fcmModel;
    fcmModel.androidChannel = _androidChannelController.text;
    fcmModel.timeToLive = _duration.getDuration(_durationValue).inSeconds;
  }
}
