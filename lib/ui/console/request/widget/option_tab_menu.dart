import 'package:fcm_app_tester/data/model/console_tab_menu.dart';
import 'package:flutter/material.dart';

class OptionTabMenu extends StatelessWidget {
  final ConsoleTabMenu? option;
  final ValueChanged<ConsoleTabMenu>? onOptionChange;

  const OptionTabMenu({
    super.key,
    this.option,
    this.onOptionChange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TabMenuItem(
            title: "Target",
            option: ConsoleTabMenu.target,
            selectedOption: option,
            onPressed: onOptionChange,
          ),
          _TabMenuItem(
            title: "Custom Data",
            option: ConsoleTabMenu.customData,
            selectedOption: option,
            onPressed: onOptionChange,
          ),
          _TabMenuItem(
            title: "Additional Option",
            option: ConsoleTabMenu.additionalOption,
            selectedOption: option,
            onPressed: onOptionChange,
          ),
        ],
      ),
    );
  }
}

class _TabMenuItem extends StatelessWidget {
  final String title;
  final ConsoleTabMenu option;
  final ConsoleTabMenu? selectedOption;
  final ValueChanged<ConsoleTabMenu>? onPressed;

  const _TabMenuItem({
    required this.title,
    required this.option,
    this.selectedOption,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = selectedOption == option;
    final color = isSelected ? colorScheme.outlineVariant : colorScheme.surfaceContainerHighest;
    return Flexible(
      flex: 1,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            elevation: const WidgetStatePropertyAll(0),
            padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
            backgroundColor: WidgetStatePropertyAll(color),
          ),
          onPressed: () {
            onPressed?.call(option);
          },
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
