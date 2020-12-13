import 'package:firebase_messaging_tester/res/theme.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  Map<TextEditingController, TextEditingController> _params = {};

  _CustomFormState() {
    _params[TextEditingController()] = TextEditingController();
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
          "Custom Data",
          style: AppTheme.tileTitle(context),
        ),
        children: _customData(),
      ),
    );
  }

  List<Widget> _customData() {
    return <Widget>[
      _paramList(),
    ];
  }

  Widget _paramList() {
    List<Widget> widgets = <Widget>[];
    for (var entry in _params.entries) {
      widgets.add(_paramItem(entry));
      widgets.add(SizedBox(height: 16));
    }
    widgets.add(SizedBox(
      width: double.infinity,
      child: RaisedButton.icon(
        onPressed: () {
          setState(() {
            _params[TextEditingController()] = TextEditingController();
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

  Widget _paramItem(
      MapEntry<TextEditingController, TextEditingController> param) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            decoration: InputDecoration(hintText: "Key"),
          ),
        ),
        Flexible(
          flex: 2,
          child: TextFormField(
            decoration: InputDecoration(hintText: "Value"),
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          iconSize: 36,
          onPressed: () {
            setState(() {
              _params.remove(param.key);
            });
          },
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}
