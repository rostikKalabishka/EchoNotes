import 'package:flutter/material.dart';

class Utilities {
  String? textFieldValidator(String val) {
    if (val.isEmpty) {
      return 'Please fill in this field';
    }

    return null;
  }

  void errorSnackBar(
      {required BuildContext context,
      required ThemeData theme,
      required String? errorMsg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: theme.cardColor,
        content: Center(
          child: Text(errorMsg ?? 'Unknown error',
              style: theme.inputDecorationTheme.errorStyle),
        ),
      ),
    );
  }
}
