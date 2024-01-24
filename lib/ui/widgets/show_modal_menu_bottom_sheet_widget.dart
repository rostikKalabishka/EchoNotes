import 'package:flutter/material.dart';

Future<void> showModalMenuBottomSheet(
    {required BuildContext context,
    required double modalHeight,
    required Widget child}) async {
  final theme = Theme.of(context);

  return showModalBottomSheet(
    backgroundColor: theme.dialogBackgroundColor,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
          height: modalHeight,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: child);
    },
  );
}
