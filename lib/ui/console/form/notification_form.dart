import 'package:fcm_app_tester/extension/build_context_extension.dart';
import 'package:fcm_app_tester/ui/console/console_cubit.dart';
import 'package:fcm_app_tester/ui/widget/app_text_field.dart';
import 'package:fcm_app_tester/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationForm extends StatelessWidget {
  const NotificationForm({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ConsoleCubit>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: cubit.notificationFormKey,
          child: Column(
            children: [
              AppTextField(
                labelText: context.l10n.console_notification_serviceAccountInput_label,
                hintText: _getServiceAccountHint(),
                keyboardType: TextInputType.multiline,
                controller: cubit.serviceAccountController,
                maxLines: 3,
                validator: (arg) {
                  if (arg == null || arg.isEmpty) {
                    return context.l10n.console_notification_serviceAccountInput_emptyError;
                  } else if (StringUtil.tryDecode(arg.trim()) == null) {
                    return context.l10n.console_notification_serviceAccountInput_invalidError;
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 24),
              AppTextField(
                labelText: context.l10n.console_notification_titleInput_label,
                hintText: context.l10n.console_notification_titleInput_hint,
                controller: cubit.titleController,
              ),
              const SizedBox(height: 24),
              AppTextField(
                labelText: context.l10n.console_notification_textInput_label,
                hintText: context.l10n.console_notification_textInput_hint,
                controller: cubit.textController,
                validator: (arg) {
                  if (arg == null || arg.isEmpty) {
                    return context.l10n.console_notification_textInput_emptyError;
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

  String _getServiceAccountHint() {
    return '{ "type": "service_account", "project_id": "app-name", "private_key_id": "", .... }';
  }
}
