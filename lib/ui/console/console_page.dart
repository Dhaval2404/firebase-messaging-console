import 'package:fcm_app_tester/data/fcm_option.dart';
import 'package:fcm_app_tester/ui/console/console_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'form/additional_option_form.dart';
import 'form/custom_data_form.dart';
import 'form/target_form.dart';
import 'request/request_body.dart';
import 'response/response_card.dart';

class ConsolePage extends StatelessWidget {
  const ConsolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConsoleCubit(),
      child: const ConsoleForm(),
    );
  }
}

class ConsoleForm extends StatefulWidget {
  const ConsoleForm({super.key});

  @override
  State<ConsoleForm> createState() => _ConsoleFormState();
}

class _ConsoleFormState extends State<ConsoleForm> {
  FCMOption _fcmOption = FCMOption.target;

  // Widgets you want to keep in memory
  final List<Widget> _widgets = [
    const TargetForm(),
    const CustomDataForm(),
    const AdditionalOptionForm(),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1024) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: _buildRequestBody(),
                  ),
                ),
                const SizedBox(width: 16),
                const Flexible(
                  flex: 1,
                  child: ResponseCard(),
                ),
              ],
            );
          } else {
            return ListView(
              shrinkWrap: true,
              children: [
                _buildRequestBody(),
                const ResponseCard(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildRequestBody() {
    return RequestBody(
      option: _fcmOption,
      onOptionChange: (option) {
        setState(() {
          _fcmOption = option;
        });
      },
      children: _widgets,
    );
  }
}
