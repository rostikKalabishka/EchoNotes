import 'package:flutter/material.dart';

class CustomBoxShadowContainer extends StatelessWidget {
  const CustomBoxShadowContainer({
    super.key,
    required this.cardInfo,
  });

  final Widget cardInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2)),
          ]),
      clipBehavior: Clip.hardEdge,
      child: cardInfo,
    );
  }
}
