import 'package:firebase_messaging_tester/res/theme.dart';
import 'package:firebase_messaging_tester/src/data/model/fcm_model.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_text_form_field.dart';

class TargetForm extends StatefulWidget {
  final FCMModel fcmModel;

  const TargetForm({Key key, this.fcmModel}) : super(key: key);

  @override
  TargetFormState createState() => TargetFormState();
}

class TargetFormState extends State<TargetForm> {
  List<TextEditingController> _controllers = new List();
  var _topicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var fcmModel = widget.fcmModel;
    _topicController.text = fcmModel.topic;
    if (fcmModel.ids == null || fcmModel.ids.isEmpty) {
      _controllers.add(TextEditingController(text: ""));
    } else {
      _controllers.addAll(
        fcmModel.ids.map((id) => TextEditingController(text: id)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomTextFormField(
          labelText: "Message topic",
          hintText: "",
          controller: _topicController,
        ),
        SizedBox(height: 18),
        Center(child: Text("Or")),
        SizedBox(height: 18),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Device Tokens",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.normal)),
        ),
        SizedBox(height: 8),
        _tokens(),
      ],
    );
  }

  Widget _tokens() {
    var widgets = <Widget>[];
    var i = 0;
    for (var controller in _controllers) {
      var widget = _paramItem(controller, i == 0);
      widgets.add(widget);
      i++;
    }

    /*widgets.add(SizedBox(
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
    ));*/

    return Column(
      children: widgets,
    );
  }

  Widget _paramItem(TextEditingController controller, bool isFirst) {
    return Container(
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300], width: 2),
              shape: BoxShape.rectangle,
            ),
            padding: EdgeInsets.all(4),
            child: IconButton(
              iconSize: 32,
              onPressed: () {
                setState(() {
                  if (isFirst) {
                    _controllers.add(TextEditingController());
                  } else {
                    _controllers.remove(controller);
                  }
                });
              },
              icon: Icon(isFirst ? Icons.add : Icons.delete_outline),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _ids() {
    return _controllers
        .map((controller) => controller.text.trim())
        .where((element) => element.isNotEmpty)
        .toList();
  }

  bool validate() {
    if (_ids().isEmpty && _topicController.text.isEmpty) {
      showError("Missing Target");
      return false;
    }
    save();
    return true;
  }

  void save() {
    widget.fcmModel.ids = _ids();
    widget.fcmModel.topic = _topicController.text;
  }

  void showError(String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
