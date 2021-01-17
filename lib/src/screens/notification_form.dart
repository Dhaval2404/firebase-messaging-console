import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../data/model/fcm_model.dart';
import 'widgets/custom_text_form_field.dart';

class NotificationForm extends StatefulWidget {
  final FCMModel fcmModel;

  const NotificationForm({Key key, this.fcmModel}) : super(key: key);

  @override
  NotificationFormState createState() => NotificationFormState();
}

class NotificationFormState extends State<NotificationForm> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _serverKeyController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.fcmModel.title;
    _messageController.text = widget.fcmModel.message;
  }

  @override
  Widget build(BuildContext context) {
    return _form();
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            labelText: "label_server_key".tr(),
            hintText: "hint_server_key".tr(),
            controller: _serverKeyController,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (arg) {
              if (arg.isEmpty) {
                return 'error_server_key'.tr();
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 18),
          CustomTextFormField(
            labelText: "label_notification_title".tr(),
            hintText: "hint_notification_title".tr(),
            controller: _titleController,
            textCapitalization: TextCapitalization.sentences,
          ),
          SizedBox(height: 18),
          CustomTextFormField(
            labelText: "label_notification_text".tr(),
            hintText: "hint_notification_text".tr(),
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (arg) {
              if (arg.isEmpty) {
                return 'error_notification_text'.tr();
              } else {
                return null;
              }
            },
          ),
          /*SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              onPressed: _submit,
              child: Text("Next"),
            ),
          ),*/
          //SizedBox(height: 28),
        ],
      ),
    );
  }

  bool validate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      widget.fcmModel.serverKey = _serverKeyController.text.trim();
      widget.fcmModel.title = _titleController.text.trim();
      widget.fcmModel.message = _messageController.text.trim();

      return true;
    } else {
      return false;
    }
  }
}
