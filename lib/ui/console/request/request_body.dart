import 'package:fcm_app_tester/data/model/console_tab_menu.dart';
import 'package:fcm_app_tester/extension/build_context_extension.dart';
import 'package:fcm_app_tester/ui/console/console_cubit.dart';
import 'package:fcm_app_tester/ui/console/form/additional_option_form.dart';
import 'package:fcm_app_tester/ui/console/form/custom_data_form.dart';
import 'package:fcm_app_tester/ui/console/form/notification_form.dart';
import 'package:fcm_app_tester/ui/console/form/target_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/option_tab_menu.dart';

class RequestBody extends StatefulWidget {
  const RequestBody({super.key});

  @override
  State<RequestBody> createState() => _RequestBodyState();
}

class _RequestBodyState extends State<RequestBody> {
  ConsoleTabMenu _option = ConsoleTabMenu.target;

  // Widgets you want to keep in memory
  final List<Widget> _widgets = [
    const TargetForm(),
    const CustomDataForm(),
    const AdditionalOptionForm(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NotificationForm(),
        const SizedBox(height: 24),
        OptionTabMenu(
          option: _option,
          onOptionChange: (option) {
            setState(() {
              _option = option;
            });
          },
        ),
        const SizedBox(height: 24),
        IndexedStack(
          index: _option.index,
          children: _widgets,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              context.read<ConsoleCubit>().send();
            },
            child: Text(context.l10n.action_send),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
