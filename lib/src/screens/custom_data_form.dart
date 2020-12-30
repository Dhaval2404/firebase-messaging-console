import 'package:firebase_messaging_tester/src/data/model/fcm_model.dart';
import 'package:flutter/material.dart';

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
    /*final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
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
    );*/
    return Column(
      children: _customData(),
    );
  }

  List<Widget> _customData() {
    return <Widget>[
      _paramList(),
    ];
  }

  Widget _paramList() {
    List<Widget> widgets = <Widget>[];
    var i =0;
    for (var entry in _params.entries) {
      widgets.add(_paramItem(entry, i==0));
      widgets.add(SizedBox(height: 16));
      i++;
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
      MapEntry<TextEditingController, TextEditingController> param, bool isFirst) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            controller: param.key,
            decoration: InputDecoration(hintText: "Key"),
          ),
        ),
        Flexible(
          flex: 2,
          child: TextFormField(
            controller: param.value,
            decoration: InputDecoration(hintText: "Value"),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300], width: 2),
            shape: BoxShape.rectangle,
          ),
          padding: EdgeInsets.all(4),
          child: isFirst?IconButton(
            iconSize: 30,
            onPressed: () {
              setState(() {
                _params[TextEditingController()] = TextEditingController();
              });
            },
            icon: Icon(Icons.add),
          ):IconButton(
            iconSize: 30,
            onPressed: () {
              setState(() {
                _params.remove(param.key);
              });
            },
            icon: Icon(Icons.delete),
          ),
        ),
      ],
    );
  }

  bool validate() {
    print("Validate Custom Data");
    save();
    return true;
  }

  void save() {
    print("Save Custom Data");

    var data = <String, String>{};
    _params.forEach((key, value) {
      print("B:"+key.text+","+value.text);
      data[key.text] = value.text;
    });
    widget.fcmModel.data = data;

    print("A:"+widget.fcmModel.data.toString());

  }
}
