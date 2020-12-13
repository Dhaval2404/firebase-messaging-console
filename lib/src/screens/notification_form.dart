import 'package:firebase_messaging_tester/res/theme.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_text_form_field.dart';

class NotificationForm extends StatefulWidget {
  @override
  _NotificationFormState createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  bool _isExpanded = true;
  var _formKey = GlobalKey<FormState>();
  var _autoValidate = false;

  var _titleController = TextEditingController();
  var _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Theme(
      data: theme,
      child: ExpansionTile(
        key: GlobalKey(),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (newValue) {
          setState(() {
            _isExpanded = newValue;
          });
        },
        maintainState: false,
        expandedAlignment: Alignment.topLeft,
        tilePadding: EdgeInsets.zero,
        title: Text(
          "Notification",
          style: AppTheme.tileTitle(context),
        ),
        children: _notification(),
      ),
    );
  }

  List<Widget> _notification() {
    return <Widget>[_form()];
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            labelText: "Notification title",
            hintText: "Enter optional title",
            controller: _titleController,
          ),
          SizedBox(height: 18),
          CustomTextFormField(
            labelText: "Notification text",
            hintText: "Enter notification text",
            controller: _messageController,
            autovalidateMode: !_autoValidate
                ? AutovalidateMode.disabled
                : AutovalidateMode.always,
            validator: (arg) {
              if (arg.isEmpty)
                return 'Please enter notification text';
              else
                return null;
            },
          ),
          SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              onPressed: _submit,
              child: Text("Next"),
            ),
          ),
          SizedBox(height: 28),
        ],
      ),
    );
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isExpanded = false;
      });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
