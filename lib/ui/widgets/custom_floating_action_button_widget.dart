import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    this.borderRadius,
    this.height,
    this.width,
    required this.dataButton,
    required this.heroTag,
  });
  final VoidCallback onPressed;
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final double? width;
  final Widget dataButton;
  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color:
                theme.floatingActionButtonTheme.backgroundColor!.withOpacity(1),
            blurRadius: 30,
            blurStyle: BlurStyle.solid,
            spreadRadius: -10.0,
            offset: const Offset(0, 2)),
      ]),
      height: height,
      width: width,
      child: FloatingActionButton(
        heroTag: heroTag,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ??
              const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
        ),
        onPressed: onPressed,
        child: dataButton,
      ),
    );
  }
}
