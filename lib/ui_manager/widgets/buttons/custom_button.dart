import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sayaratech/ui_manager/colors_manager.dart';
import 'package:sayaratech/ui_manager/fixed_numbers_manager.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: width ?? Get.width * 0.3,
          height: height ?? 40,
          decoration: BoxDecoration(
              color: backgroundColor ?? primaryColor,
              borderRadius:
                  BorderRadius.circular(fixedBorderRadiusfullyCircular)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: textColor ?? whiteColor, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
