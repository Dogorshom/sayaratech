import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/authentication/logout.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';
import '../../../ui_manager/widgets/buttons/custom_button.dart';

logoutDialog() async {
  Get.defaultDialog(
    backgroundColor: primaryColor,
    title: "Logout".tr,
    content: Text(
      "Logout Sentence".tr,
      textAlign: TextAlign.center,
    ),
    confirm: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child: Text(
            "Cancel".tr,
            style: Get.textTheme.titleSmall!.copyWith(color: whiteColor),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        CustomButton(
          text: "Logout".tr,
          backgroundColor: redColor,
          onTap: logout,
          // textColor: ,
        ),
      ],
    ),
    contentPadding: const EdgeInsets.all(fixedPadding),
  );
}
