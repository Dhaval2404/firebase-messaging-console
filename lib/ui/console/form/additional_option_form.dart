import 'package:fcm_app_tester/data/model/message_duration.dart';
import 'package:fcm_app_tester/ui/console/console_cubit.dart';
import 'package:fcm_app_tester/ui/widget/app_text_field.dart';
import 'package:fcm_app_tester/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdditionalOptionForm extends StatefulWidget {
  const AdditionalOptionForm({super.key});

  @override
  AdditionalOptionFormState createState() => AdditionalOptionFormState();
}

class AdditionalOptionFormState extends State<AdditionalOptionForm> {
  MessageDuration _duration = MessageDuration.weeks;
  int _durationValue = 0;

  final _androidChannelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConsoleCubit>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: cubit.additionalOptionFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _option(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _option(BuildContext context) {
    var cubit = context.read<ConsoleCubit>();
    return <Widget>[
      AppTextField(
        labelText: "Notification image (optional)",
        hintText: "Example: https://yourapp.com/image.png",
        controller: cubit.imageController,
        validator: (arg) {
          if (arg == null || arg.isEmpty) {
            return null;
          } else if (!StringUtil.isValidUrl(arg)) {
            return "Please enter valid image url";
          } else {
            return null;
          }
        },
      ),
      const SizedBox(height: 24),
      AppTextField(
        labelText: "Android notification channel (optional)",
        hintText: "",
        controller: _androidChannelController,
      ),
      const SizedBox(height: 24),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Expires",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
      const SizedBox(height: 8),
      SizedBox(
        width: 372,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: DropdownButtonFormField<int>(
                value: _durationValue,
                elevation: 16,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _durationValue = newValue ?? 0;
                  });
                },
                items: _duration.range.map<DropdownMenuItem<int>>((value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              flex: 1,
              child: DropdownButtonFormField<MessageDuration>(
                value: _duration,
                elevation: 16,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  if (newValue == null) return;
                  setState(() {
                    if (newValue.maxValue < _durationValue) {
                      _durationValue = newValue.maxValue;
                    }
                    _duration = newValue;
                  });
                },
                items: MessageDuration.values.map<DropdownMenuItem<MessageDuration>>((value) {
                  return DropdownMenuItem<MessageDuration>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
