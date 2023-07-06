import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/ui_manager/colors_manager.dart';
import 'package:sayaratech/ui_manager/fixed_numbers_manager.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greyColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(fixedBorderRadius),
        color: Get.theme.cardColor,
      ),
      child: child,
    );
  }
}
