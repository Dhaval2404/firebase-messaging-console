import 'package:fcm_app_tester/ui/console/console_cubit.dart';
import 'package:fcm_app_tester/ui/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CustomDataForm extends StatefulWidget {
  const CustomDataForm({super.key});

  @override
  CustomDataFormState createState() => CustomDataFormState();
}

class CustomDataFormState extends State<CustomDataForm> {
  final _widgets = <Widget>[];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        var customData = context.read<ConsoleCubit>().customData;
        if (customData.isEmpty) {
          customData[TextEditingController()] = TextEditingController();
          _updateWidgets();
        }
      });
    });
  }

  _updateWidgets() {
    var customData = context.read<ConsoleCubit>().customData;
    var i = 0;
    _widgets.clear();
    for (var entry in customData.entries) {
      _widgets.add(_paramItem(entry, i == 0));
      _widgets.add(const SizedBox(height: 16));
      i++;
    }
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
                _updateWidgets();
              });
            },
            icon: Icon(isFirst ? Icons.add_rounded : Icons.delete_outline_rounded),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: _widgets,
        ),
      ),
    );
  }
}
