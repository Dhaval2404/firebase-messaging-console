import 'package:fcm_app_tester/extension/build_context_extension.dart';
import 'package:fcm_app_tester/ui/console/console_cubit.dart';
import 'package:fcm_app_tester/ui/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDataForm extends StatefulWidget {
  const CustomDataForm({super.key});

  @override
  CustomDataFormState createState() => CustomDataFormState();
}

class CustomDataFormState extends State<CustomDataForm> {
  final _widgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateWidgets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: _widgets,
        ),
      ),
    );
  }

  _updateWidgets() {
    final customData = context.read<ConsoleCubit>().customData;
    if (customData.isEmpty) {
      customData[TextEditingController()] = TextEditingController();
    }

    var i = 0;
    _widgets.clear();
    for (final param in customData.entries) {
      _widgets.add(
        _CustomDataForm(
          param: param,
          isFirst: i == 0,
          onAdd: () {
            customData.remove(param.key);
            _updateWidgets();
          },
          onRemove: () {
            customData[TextEditingController()] = TextEditingController();
            _updateWidgets();
          },
        ),
      );
      _widgets.add(const SizedBox(height: 16));
      i++;
    }

    setState(() {});
  }
}

class _CustomDataForm extends StatelessWidget {
  final bool isFirst;
  final MapEntry<TextEditingController, TextEditingController> param;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  const _CustomDataForm({
    required this.param,
    required this.isFirst,
    this.onAdd,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: AppTextField(
            labelText: context.l10n.console_customData_key_label,
            hintText: context.l10n.console_customData_key_hint,
            controller: param.key,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: 2,
          child: AppTextField(
            labelText: context.l10n.console_customData_value_label,
            hintText: context.l10n.console_customData_value_hint,
            controller: param.value,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: IconButton(
            onPressed: () {
              isFirst ? onAdd?.call() : onRemove?.call();
            },
            icon: Icon(
              isFirst ? Icons.add_rounded : Icons.delete_outline_rounded,
            ),
          ),
        ),
      ],
    );
  }
}
