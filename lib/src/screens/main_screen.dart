import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constant/app_constant.dart';
import '../data/constant/fcm_option.dart';
import '../data/model/fcm_model.dart';
import '../data/model/fcm_response.dart';
import '../data/repository/fcm_repository.dart';
import '../screens/fcm_response_widget.dart';
import '../util/navigation_util.dart';
import 'additional_option_form.dart';
import 'contributor_widget.dart';
import 'custom_data_form.dart';
import 'notification_form.dart';
import 'target_form.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FCMOption _fcmOption = FCMOption.target;

  final GlobalKey<NotificationFormState> _notificationFormStateKey =
      GlobalKey();

  final GlobalKey<TargetFormState> _targetFormStateKey = GlobalKey();
  final GlobalKey<CustomDataFormState> _customDataFormStateKey = GlobalKey();
  final GlobalKey<AdditionalOptionFormState> _additionalOptionFormStateKey =
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
        title: Text('app_name'.tr()),
        actions: _actions(),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _validateForm,
        label: Text(
          'action_send_notification'.tr(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  List<Widget> _actions() {
    return <Widget>[
      FlatButton(
        onPressed: () {
          NavigationUtil.launchURL(AppConstant.githubURL);
        },
        child: Image.asset(
          'assets/images/ic_github.png',
          width: 32,
          height: 32,
        ),
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
    return Column(
      children: [
        ContributorWidget(),
        Expanded(
          child: Row(
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
          ),
        ),
      ],
    );
  }

  Widget _bodySmall() {
    var widgets = <Widget>[];
    widgets.add(ContributorWidget());
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
          title: 'title_target'.tr(),
          fcmOption: FCMOption.target,
        ),
        _tabMenuItem(
          title: 'title_custom_data'.tr(),
          fcmOption: FCMOption.customData,
        ),
        _tabMenuItem(
          title: 'title_additional_option'.tr(),
          fcmOption: FCMOption.additionalOption,
        ),
      ],
    );
  }

  Widget _tabMenuItem({@required String title, FCMOption fcmOption}) {
    var isChecked = _fcmOption == fcmOption;
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
    var status1 = _notificationFormStateKey.currentState.validate();

    var status2 = _targetFormStateKey.currentState?.validate();
    _customDataFormStateKey.currentState?.validate();
    _additionalOptionFormStateKey.currentState?.validate();

    if (status1 == false || status2 == false) return;

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
