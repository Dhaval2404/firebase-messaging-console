import 'package:fcm_app_tester/ui/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../console_cubit.dart';

class CustomDataForm extends StatefulWidget {
  const CustomDataForm({super.key});

  @override
  CustomDataFormState createState() => CustomDataFormState();
}

class CustomDataFormState extends State<CustomDataForm> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        var customData = context.read<ConsoleCubit>().customData;
        if (customData.isEmpty) {
          customData[TextEditingController()] = TextEditingController();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var customData = context.read<ConsoleCubit>().customData;
    var widgets = <Widget>[];
    var i = 0;
    for (var entry in customData.entries) {
      widgets.add(_paramItem(entry, i == 0));
      widgets.add(const SizedBox(height: 16));
      i++;
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: widgets,
        ),
      ),
    );
  }

  Widget _paramItem(
    MapEntry<TextEditingController, TextEditingController> param,
    bool isFirst,
  ) {
    var customData = context.read<ConsoleCubit>().customData;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: AppTextField(
            labelText: "Key",
            hintText: "Enter optional key",
            controller: param.key,
            // decoration: InputDecoration(hintText: "Key"),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: 2,
          child: AppTextField(
            labelText: "Value",
            hintText: "Enter optional value",
            controller: param.value,
            // decoration: InputDecoration(hintText: "Key"),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: IconButton(
            onPressed: () {
              setState(() {
                if (isFirst) {
                  customData[TextEditingController()] = TextEditingController();
                } else {
                  customData.remove(param.key);
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

  void save() {}
}
