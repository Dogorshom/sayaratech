import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ui_manager/colors_manager.dart';

///Show internet error to the user
internetErrorOverlay({bool isTimeOut = false}) {
  return Get.snackbar("No Internet", "Please check your internet and try again",
      backgroundColor: blackColor.withOpacity(0.65),
      colorText: whiteColor,
      icon: Icon(
        Icons.error_outline_rounded,
        color: redColor,
        size: 30,
      ),
      titleText: Text(
        isTimeOut ? "TimeOut" : "No Internet",
        style: Get.textTheme.titleLarge!.copyWith(color: redColor),
      ),
      messageText: Text(
        "Please check your internet and try again",
        style: Get.textTheme.bodyLarge!.copyWith(color: whiteColor),
      ),
      duration: const Duration(seconds: 4));
}
