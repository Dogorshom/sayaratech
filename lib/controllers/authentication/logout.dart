import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pages/authentication/login_screen.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';
import '../../../ui_manager/widgets/buttons/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

logout() async {
  Get.defaultDialog(
    backgroundColor: primaryColor,
    title: "Logout",
    content: const Text(
      "You are going to logout from the application, Are you sure you want to logout?",
      textAlign: TextAlign.center,
    ),
    confirm: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child: Text(
            "Cancel",
            style: Get.textTheme.titleSmall!.copyWith(color: whiteColor),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        CustomButton(
          text: "Logout",
          backgroundColor: redColor,
          onTap: () async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.clear();
            Get.to(() => const LoginScreen());
          },
          // textColor: ,
        ),
      ],
    ),
    contentPadding: const EdgeInsets.all(fixedPadding),
  );
}
