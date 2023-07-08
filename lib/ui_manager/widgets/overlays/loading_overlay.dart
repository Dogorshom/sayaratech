import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../ui_manager/colors_manager.dart';
import '../../fixed_numbers_manager.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      color: Get.theme.focusColor.withOpacity(0.3),
      alignment: Alignment.center,
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius:
                BorderRadius.circular(fixedBorderRadiusfullyCircular)),
        child: Padding(
          padding: const EdgeInsets.all(fixedMainPadding),
          child: CircularProgressIndicator(
            color: whiteColor,
            backgroundColor: secondaryColor,
            strokeWidth: 2.8,
          ),
        ),
      ),
    );
  }
}
