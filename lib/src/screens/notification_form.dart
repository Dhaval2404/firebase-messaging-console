import 'package:flutter/material.dart';

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
            labelText: "Firebase Server Key",
            hintText: "Enter firebase server key",
            controller: _serverKeyController,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (arg) {
              if (arg.isEmpty) {
                return 'Please enter firebase server key';
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 18),
          CustomTextFormField(
            labelText: "Notification title",
            hintText: "Enter optional title",
            controller: _titleController,
            textCapitalization: TextCapitalization.sentences,
          ),
          SizedBox(height: 18),
          CustomTextFormField(
            labelText: "Notification text",
            hintText: "Enter notification text",
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (arg) {
              if (arg.isEmpty) {
                return 'Please enter notification text';
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

      widget.fcmModel.serverKey = _serverKeyController.text;
      widget.fcmModel.title = _titleController.text;
      widget.fcmModel.message = _messageController.text;

      return true;
    } else {
      return false;
    }
  }
}
