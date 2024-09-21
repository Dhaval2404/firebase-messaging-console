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
                labelText: "Topic",
                hintText: "",
                controller: cubit.topicController,
                validator: (arg) {
                  if ((arg == null || arg.isEmpty) && cubit.tokenController.text.isEmpty) {
                    return 'Please provide topic or device token';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 16),
              const Center(child: Text("Or")),
              const SizedBox(height: 16),
              AppTextField(
                labelText: "Device Token",
                hintText: "",
                controller: cubit.tokenController,
                validator: (arg) {
                  if ((arg == null || arg.isEmpty) && cubit.topicController.text.isEmpty) {
                    return 'Please provide device token or topic';
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
