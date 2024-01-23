import 'package:flutter/material.dart';
import 'package:note_app/ui/widgets/custom_box_shadow_container_widget.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.theme,
    required this.size,
    required this.onTap,
    required this.child,
  });

  final ThemeData theme;
  final Size size;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: CustomBoxShadowContainer(
        cardColor: theme.cardColor,
        cardInfo: SizedBox(
          width: size.width * 0.14,
          height: size.width * 0.14,
          child: Center(child: child),
        ),
      ),
    );
  }
}
