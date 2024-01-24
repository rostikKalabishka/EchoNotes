import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.textEditorController,
      this.hintText,
      required this.maxLines,
      this.validator});
  final TextEditingController textEditorController;
  final String? hintText;
  final int maxLines;
  final String? Function(String?)? validator;
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
            validator: validator,
            maxLines: maxLines,
            decoration: InputDecoration(
              errorStyle: const TextStyle(color: Colors.red),
              hintText: hintText,
              border: InputBorder.none,
            ),
            controller: textEditorController,
          ),
        ),
      ),
    );
  }
}
