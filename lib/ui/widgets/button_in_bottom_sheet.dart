import 'package:flutter/material.dart';

class ButtonInBottomSheet extends StatelessWidget {
  const ButtonInBottomSheet(
      {super.key,
      required this.onTap,
      required this.backgroundColor,
      required this.iconColor,
      required this.icon,
      required this.text});
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 16,
      onTap: onTap,
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 32,
            color: iconColor,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(text)
      ]),
    );
  }
}
