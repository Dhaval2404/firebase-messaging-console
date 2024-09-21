import 'package:fcm_app_tester/data/fcm_option.dart';
import 'package:flutter/material.dart';

class OptionTabMenu extends StatelessWidget {
  final FCMOption? selectedOption;
  final ValueChanged<FCMOption>? onOptionChange;

  const OptionTabMenu({
    super.key,
    this.selectedOption,
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
            option: FCMOption.target,
            isSelected: selectedOption == FCMOption.target,
            onClick: () {
              onOptionChange?.call(FCMOption.target);
            },
          ),
          _TabMenuItem(
            title: "Custom Data",
            option: FCMOption.customData,
            isSelected: selectedOption == FCMOption.customData,
            onClick: () {
              onOptionChange?.call(FCMOption.customData);
            },
          ),
          _TabMenuItem(
            title: "Additional Option",
            option: FCMOption.additionalOption,
            isSelected: selectedOption == FCMOption.additionalOption,
            onClick: () {
              onOptionChange?.call(FCMOption.additionalOption);
            },
          ),
        ],
      ),
    );
  }
}

class _TabMenuItem extends StatelessWidget {
  final String title;
  final FCMOption option;
  final bool isSelected;
  final VoidCallback? onClick;

  const _TabMenuItem({
    required this.title,
    required this.option,
    this.isSelected = false,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
          onPressed: onClick,
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
