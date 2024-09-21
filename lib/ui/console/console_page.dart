import 'package:fcm_app_tester/ui/console/console_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'request/request_body.dart';
import 'response/response_body.dart';

class ConsolePage extends StatelessWidget {
  const ConsolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConsoleCubit(),
      child: const _ConsoleForm(),
    );
  }
}

class _ConsoleForm extends StatelessWidget {
  const _ConsoleForm();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1024) {
            return const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: RequestBody(),
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  flex: 1,
                  child: ResponseBody(),
                ),
              ],
            );
          } else {
            return ListView(
              shrinkWrap: true,
              children: const [
                RequestBody(),
                ResponseBody(),
              ],
            );
          }
        },
      ),
    );
  }
}
