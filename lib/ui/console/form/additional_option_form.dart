import 'package:fcm_app_tester/data/model/message_duration.dart';
import 'package:fcm_app_tester/extension/build_context_extension.dart';
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
        labelText: context.l10n.console_additionalOption_imageUrlInput_label,
        hintText: context.l10n.console_additionalOption_imageUrlInput_hint,
        controller: cubit.imageController,
        validator: (arg) {
          if (arg == null || arg.isEmpty) {
            return null;
          } else if (!StringUtil.isValidUrl(arg)) {
            return context.l10n.console_additionalOption_imageUrlInput_invalidError;
          } else {
            return null;
          }
        },
      ),
      const SizedBox(height: 24),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          context.l10n.console_additionalOption_expires_label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
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
                value: cubit.durationValue,
                elevation: 16,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setState(() {
                    cubit.durationValue = newValue ?? 0;
                  });
                },
                items: cubit.duration.range.map<DropdownMenuItem<int>>((value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(
                      value.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              flex: 1,
              child: DropdownButtonFormField<MessageDuration>(
                value: cubit.duration,
                elevation: 16,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  if (newValue == null) return;
                  setState(() {
                    if (newValue.maxValue < cubit.durationValue) {
                      cubit.durationValue = newValue.maxValue;
                    }
                    cubit.duration = newValue;
                  });
                },
                items: MessageDuration.values.map<DropdownMenuItem<MessageDuration>>((value) {
                  return DropdownMenuItem<MessageDuration>(
                    value: value,
                    child: Text(
                      value.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
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
