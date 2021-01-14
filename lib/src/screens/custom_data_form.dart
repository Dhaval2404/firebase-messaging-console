import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../data/model/fcm_model.dart';

class CustomDataForm extends StatefulWidget {
  final FCMModel fcmModel;

  const CustomDataForm({Key key, this.fcmModel}) : super(key: key);

  @override
  CustomDataFormState createState() => CustomDataFormState();
}

class CustomDataFormState extends State<CustomDataForm> {
  final Map<TextEditingController, TextEditingController> _params = {};

  @override
  void initState() {
    super.initState();
    var fcmModel = widget.fcmModel;
    if (fcmModel == null || fcmModel.data == null || fcmModel.data.isEmpty) {
      print("fcmModel is null or empty");
      _params[TextEditingController()] = TextEditingController();
    } else {
      print(fcmModel.data.toString());
      fcmModel.data.forEach((key, value) {
        _params[TextEditingController(text: key)] =
            TextEditingController(text: value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    var i = 0;
    for (var entry in _params.entries) {
      widgets.add(_paramItem(entry, i == 0));
      widgets.add(SizedBox(height: 16));
      i++;
    }
    /*widgets.add(SizedBox(
      width: double.infinity,
      child: FlatButton.icon(
        onPressed: () {
          setState(() {
            _params[TextEditingController()] = TextEditingController();
          });
        },
        icon: Icon(Icons.add),
        label: Text(
          "Add new",
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    ));*/
    return Column(
      children: widgets,
    );
  }

  Widget _paramItem(
      MapEntry<TextEditingController, TextEditingController> param,
      bool isFirst) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            controller: param.key,
            decoration: InputDecoration(hintText: "hint_key".tr()),
          ),
        ),
        Flexible(
          flex: 2,
          child: TextFormField(
            controller: param.value,
            decoration: InputDecoration(hintText: "hint_value".tr()),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300], width: 2),
            shape: BoxShape.rectangle,
          ),
          padding: EdgeInsets.all(4),
          child: IconButton(
            onPressed: () {
              setState(() {
                if (isFirst) {
                  _params[TextEditingController()] = TextEditingController();
                } else {
                  _params.remove(param.key);
                }
              });
            },
            icon: Icon(isFirst ? Icons.add : Icons.delete_outline),
          ),
        ),
      ],
    );
  }

  bool validate() {
    save();
    return true;
  }

  void save() {
    var data = <String, String>{};
    _params.forEach((key, value) {
      if (key.text.isNotEmpty) {
        data[key.text] = value.text;
      }
    });
    widget.fcmModel.data = data;
  }
}
