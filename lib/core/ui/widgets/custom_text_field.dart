import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.textEditorController,
      this.hintText,
      this.maxLines,
      this.validator,
      this.mixLines,
      required this.autofocus});
  final TextEditingController textEditorController;
  final String? hintText;
  final int? maxLines;
  final String? Function(String?)? validator;
  final int? mixLines;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 3,
              color: theme.floatingActionButtonTheme.backgroundColor!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextFormField(
            style: theme.inputDecorationTheme.hintStyle,
            autofocus: autofocus,
            validator: validator,
            minLines: mixLines,
            maxLines: maxLines,
            decoration: InputDecoration(
              errorStyle: theme.inputDecorationTheme.errorStyle,
              hintText: hintText,
              hintStyle: theme.inputDecorationTheme.hintStyle,
              border: InputBorder.none,
            ),
            controller: textEditorController,
          ),
        ),
      ),
    );
  }
}
