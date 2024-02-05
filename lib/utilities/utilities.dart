import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Utilities {
  String? textFieldValidator(String val) {
    if (val.isEmpty) {
      return 'Please fill in this field';
    }

    return null;
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
    );
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
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
