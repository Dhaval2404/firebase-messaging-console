import 'package:firebase_messaging_tester/res/theme.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_text_form_field.dart';

class TargetForm extends StatefulWidget {
  @override
  _TargetFormState createState() => _TargetFormState();
}

class _TargetFormState extends State<TargetForm> {
  List<TextEditingController> _controllers = new List();

  @override
  void initState() {
    super.initState();
    _controllers.add(TextEditingController(text: ""));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Theme(
      data: theme,
      child: ExpansionTile(
        initiallyExpanded: false,
        tilePadding: EdgeInsets.zero,
        title: Text(
          "Target",
          style: AppTheme.tileTitle(context),
        ),
        children: _target(),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  List<Widget> _target() {
    return <Widget>[
      CustomTextFormField(labelText: "Message topic", hintText: ""),
      SizedBox(height: 18),
      Center(child: Text("Or")),
      SizedBox(height: 18),
      Text("Device Tokens",
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.normal)),
      SizedBox(height: 8),
      _tokens(),
      SizedBox(height: 18),
      Align(
        alignment: Alignment.centerRight,
        child: RaisedButton(
          onPressed: () {},
          child: Text("Next"),
        ),
      )
    ];
  }

  Widget _tokens() {
    var widgets = <Widget>[];
    for (var controller in _controllers) {
      var widget = Container(
          padding: EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(),
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                iconSize: 32,
                onPressed: () {
                  setState(() {
                    _controllers.remove(controller);
                  });
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ));
      widgets.add(widget);
    }

    widgets.add(SizedBox(
      width: double.infinity,
      child: RaisedButton.icon(
        onPressed: () {
          setState(() {
            _controllers.add(TextEditingController());
          });
        },
        icon: Icon(Icons.add),
        label: Text("Add new"),
      ),
    ));

    return Column(
      children: widgets,
    );
  }
}
