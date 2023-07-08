import 'package:flutter/material.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greyColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(fixedBorderRadius),
        color: Theme.of(context).cardColor,
      ),
      child: child,
    );
  }
}
