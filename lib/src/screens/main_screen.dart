import 'package:firebase_messaging_tester/src/data/constant/fcm_option.dart';
import 'package:firebase_messaging_tester/src/data/model/fcm_model.dart';
import 'package:flutter/material.dart';

import 'additional_option_form.dart';
import 'custom_data_form.dart';
import 'notification_form.dart';
import 'target_form.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FCMOption _fcmOption = FCMOption.target;

  GlobalKey<NotificationFormState> _notificationFormStateKey = GlobalKey();

  GlobalKey<TargetFormState> _targetFormStateKey = GlobalKey();
  GlobalKey<CustomDataFormState> _customDataFormStateKey = GlobalKey();
  GlobalKey<AdditionalOptionFormState> _additionalOptionFormStateKey =
      GlobalKey();

  List<Widget> _widgets;
  FCMModel _fcmModel;

  @override
  void initState() {
    super.initState();
    _fcmModel = FCMModel();

    _widgets = [
      TargetForm(
        fcmModel: _fcmModel,
        key: _targetFormStateKey,
      ),
      CustomDataForm(
        fcmModel: _fcmModel,
        key: _customDataFormStateKey,
      ),
      AdditionalOptionForm(
        fcmModel: _fcmModel,
        key: _additionalOptionFormStateKey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase FCM Tester"),
        ),
        body: _body(),
    );
  }

  Widget _body() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(12),
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: NotificationForm(
            key: _notificationFormStateKey,
            fcmModel: _fcmModel,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _tabMenu(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: _tabBody(),
        ),
        SizedBox(height: 18),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(left: 16),
          child: RaisedButton(
            onPressed: _validateForm,
            child: Text("Send Notification"),
          ),
        ),
        SizedBox(height: 18),
      ],
    );
  }

  Widget _tabBody() {
    /*return IndexedStack(
      index: _fcmOption.index,
      children: [
        TargetForm(),
        CustomForm(),
        AdditionalOptionForm(),
      ],
    );*/
    /*switch(_fcmOption.index){
      case 1:
        return CustomForm();
      case 2:
        return AdditionalOptionForm();
      default:
        return TargetForm();
    }*/
    return _widgets[_fcmOption.index];
  }

  Widget _tabMenu() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tabMenuItem(
          title: "Target",
          fcmOption: FCMOption.target,
        ),
        _tabMenuItem(
          title: "Custom Data",
          fcmOption: FCMOption.custom_data,
        ),
        _tabMenuItem(
          title: "Additional Option",
          fcmOption: FCMOption.additional_option,
        ),
      ],
    );
  }

  Widget _tabMenuItem({@required String title, FCMOption fcmOption}) {
    bool isChecked = _fcmOption == fcmOption;
    return Flexible(
      flex: 1,
      child: Container(
        width: double.infinity,
        child: FlatButton(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue),
          ),
          color: isChecked ? Colors.blue : Colors.grey[100],
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            _targetFormStateKey.currentState?.save();
            _customDataFormStateKey.currentState?.save();
            _additionalOptionFormStateKey.currentState?.save();

            setState(() {
              _fcmOption = fcmOption;
            });
          },
        ),
      ),
    );
  }

  void _validateForm() {
    _notificationFormStateKey.currentState.validate();

    _targetFormStateKey.currentState?.validate();
    _customDataFormStateKey.currentState?.validate();
    _additionalOptionFormStateKey.currentState?.validate();

    if ((_fcmModel.ids == null || _fcmModel.ids.isEmpty) &&
        (_fcmModel.topic == null || _fcmModel.topic.trim().isEmpty)) {
      print("Missing Targeted Devices");
    }
    print(_fcmModel.toString());
  }
}
