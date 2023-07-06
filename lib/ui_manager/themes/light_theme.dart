import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors_manager.dart';
import '../fixed_numbers_manager.dart';

ThemeData lightThemeData = ThemeData.light().copyWith(
  useMaterial3: true,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: const Color(0xffF6F6F6),
  shadowColor: Colors.black.withOpacity(0.2),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  //We used cardColor as same color as the theme
  //If light theme its white and if dark theme its black
  cardColor: whiteColor,
  //We used focusColor as inversed color of the theme
  //If light theme its black and if dark theme its white
  focusColor: blackColor,
  appBarTheme: AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: greyColor)),
  inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      hintStyle: Get.textTheme.bodyMedium!
          .copyWith(fontSize: 14, color: blackColor.withOpacity(0.4)),
      filled: true,
      fillColor: whiteColor,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fixedBorderRadius),
          borderSide: BorderSide.none)),
);
