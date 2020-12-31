import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final AutovalidateMode autovalidateMode;
  final FormFieldValidator<String> validator;
  final int maxLines;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  const CustomTextFormField(
      {@required this.labelText,
      @required this.hintText,
      this.controller,
      this.autovalidateMode,
      this.validator,
      this.maxLines = 1,
      this.keyboardType = TextInputType.text,
      this.textCapitalization = TextCapitalization.none});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(labelText,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.normal)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          autovalidateMode: autovalidateMode,
          validator: validator,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        )
      ],
    );
  }
}
