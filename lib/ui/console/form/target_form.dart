import 'package:fcm_app_tester/extension/build_context_extension.dart';
import 'package:fcm_app_tester/ui/console/console_cubit.dart';
import 'package:fcm_app_tester/ui/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TargetForm extends StatelessWidget {
  const TargetForm({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ConsoleCubit>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: cubit.targetFormKey,
          child: Column(
            children: <Widget>[
              AppTextField(
                labelText: context.l10n.console_target_topicInput_label,
                hintText: "",
                controller: cubit.topicController,
                validator: (arg) {
                  if ((arg == null || arg.isEmpty) && cubit.tokenController.text.isEmpty) {
                    return context.l10n.console_target_topicInput_emptyError;
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 16),
              Center(child: Text(context.l10n.console_target_or_label)),
              const SizedBox(height: 16),
              AppTextField(
                labelText: context.l10n.console_target_tokenInput_label,
                hintText: "",
                controller: cubit.tokenController,
                validator: (arg) {
                  if ((arg == null || arg.isEmpty) && cubit.topicController.text.isEmpty) {
                    return context.l10n.console_target_tokenInput_emptyError;
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
