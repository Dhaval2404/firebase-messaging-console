
import 'package:fcm_app_tester/data/fcm_option.dart';
import 'package:fcm_app_tester/ui/console/console_cubit.dart';
import 'package:fcm_app_tester/ui/console/form/notification_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/option_tab_menu.dart';

class RequestBody extends StatelessWidget {
  final List<Widget> children;
  final FCMOption option;
  final ValueChanged<FCMOption> onOptionChange;

  const RequestBody({
    super.key,
    required this.option,
    required this.children,
    required this.onOptionChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NotificationForm(),
        const SizedBox(height: 24),
        OptionTabMenu(
          selectedOption: option,
          onOptionChange: onOptionChange,
        ),
        const SizedBox(height: 24),
        IndexedStack(
          index: option.index,
          children: children,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              context.read<ConsoleCubit>().validate();
            },
            child: const Text("Send"),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
