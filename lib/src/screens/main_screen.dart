import 'package:firebase_messaging_tester/src/data/constant/fcm_option.dart';
import 'package:firebase_messaging_tester/src/data/model/fcm_model.dart';
import 'package:firebase_messaging_tester/src/data/model/fcm_response.dart';
import 'package:firebase_messaging_tester/src/data/repository/fcm_repository.dart';
import 'package:firebase_messaging_tester/src/screens/fcm_response_widget.dart';
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
  FCMResponse _fcmResponse;
  int _fcmResponseStatus;

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
        actions: _actions(),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _validateForm,
        label: Text(
          "Send Notification",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  List<Widget> _actions() {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.login),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.share),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.wallet_giftcard_sharp),
        onPressed: () {},
      ),
    ];
  }

  Widget _body() {
    var width = MediaQuery.of(context).size.width;
    if (width > 1200.0) {
      return _bodyLarge();
    } else {
      return _bodySmall();
    }
  }

  Widget _bodyLarge() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(6),
            children: _requestBody(),
          ),
          flex: 1,
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(6),
            children: _responseBody(),
          ),
          flex: 1,
        )
      ],
    );
  }

  Widget _bodySmall() {
    var widgets = <Widget>[];
    widgets.addAll(_requestBody());
    widgets.add(SizedBox(height: 18));
    widgets.addAll(_responseBody());
    widgets.add(SizedBox(height: 64));

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(6),
      children: widgets,
    );
  }

  List<Widget> _requestBody() {
    return <Widget>[
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.grey[100],
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: NotificationForm(
            key: _notificationFormStateKey,
            fcmModel: _fcmModel,
          ),
        ),
      ),
      SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: _tabMenu(),
      ),
      SizedBox(height: 8),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.grey[100],
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: _widgets[_fcmOption.index],
        ),
      ),
    ];
  }

  List<Widget> _responseBody() {
    return <Widget>[
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.grey[100],
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: FCMResponseWidget(
            response: _fcmResponse,
            status: _fcmResponseStatus,
          ),
        ),
      ),
    ];
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
          shape: isChecked
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(color: Colors.grey[300]),
                )
              : null,
          color: isChecked ? Colors.grey[300] : Colors.grey[100],
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

  void _validateForm() async {
    _notificationFormStateKey.currentState.validate();

    _targetFormStateKey.currentState?.validate();
    _customDataFormStateKey.currentState?.validate();
    _additionalOptionFormStateKey.currentState?.validate();

    //For Testing
    _fcmModel.dryRun = false;

    var response = await FCMRepository().send(_fcmModel);
    if (response != null) {
      setState(() {
        _fcmResponseStatus = response.response.statusCode;
        if (_fcmResponseStatus == 200) {
          _fcmResponse = response.data;
        }
      });
    }
  }
}
