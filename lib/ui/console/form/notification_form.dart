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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: cubit.notificationFormKey,
          child: Column(
            children: [
              AppTextField(
                labelText: "Service account json",
                hintText: getServiceAccountJsonHint(),
                keyboardType: TextInputType.multiline,
                controller: cubit.serviceAccountController,
                maxLines: 3,
                validator: (arg) {
                  if (arg == null || arg.isEmpty) {
                    return 'Please provide service account json';
                  } else if (StringUtil.tryDecode(arg.trim()) == null) {
                    return 'Please provide valid service account json';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 24),
              AppTextField(
                labelText: "Notification title",
                hintText: "Enter optional title",
                controller: cubit.titleController,
              ),
              const SizedBox(height: 24),
              AppTextField(
                labelText: "Notification text",
                hintText: "Enter notification text",
                controller: cubit.textController,
                validator: (arg) {
                  if (arg == null || arg.isEmpty) {
                    return 'Please provide notification text';
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

  String getServiceAccountJsonHint() {
    return """
{
  "type": "service_account",
  "project_id": "app-name",
  "private_key_id": "",
  ....
}
""";
  }
}
