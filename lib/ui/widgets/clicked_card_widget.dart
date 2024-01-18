import 'package:flutter/material.dart';

import 'custom_box_shadow_container_widget.dart';

class ClickedCardWidget extends StatelessWidget {
  const ClickedCardWidget({
    super.key,
    required this.cardInfo,
    required this.onTap,
  });
  final Widget cardInfo;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CustomBoxShadowContainer(cardInfo: cardInfo),
      Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: onTap),
      )
    ]);
  }
}
