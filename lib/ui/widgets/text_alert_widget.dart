import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/ui/widgets/custom_text_field.dart';

Future openDialog<T>(
        {required BuildContext context,
        required T state,
        required VoidCallback saveName,
        String? Function(String?)? validator,
        required TextEditingController controller}) =>
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);

        return AlertDialog(
          backgroundColor: theme.dialogBackgroundColor,
          actions: [
            TextButton(
              onPressed: () {
                AutoRouter.of(context).pop('Cancel');
              },
              child: Text('Cancel', style: theme.textTheme.labelLarge),
            ),
            TextButton(
              onPressed: () {
                saveName();
                AutoRouter.of(context).pop('OK');
              },
              child: Text('OK', style: theme.textTheme.labelLarge),
            ),
          ],
          title: Text(
            'Make a change',
            style: theme.textTheme.labelLarge,
          ),
          content: CustomTextField(
            validator: validator,
            maxLines: 1,
            mixLines: 1,
            textEditorController: controller,
            autofocus: true,
          ),
        );
      },
    );
