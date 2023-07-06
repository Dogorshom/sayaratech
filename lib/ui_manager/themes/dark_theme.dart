import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors_manager.dart';
import '../fixed_numbers_manager.dart';

ThemeData darkThemeData = ThemeData.dark().copyWith(
  useMaterial3: true,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: const Color.fromARGB(255, 1, 15, 20),
  shadowColor: Colors.white.withOpacity(0.2),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  //We used cardColor as same color as the theme
  //If light theme its white and if dark theme its black
  cardColor: const Color(0xff021821),
  //We used focusColor as inversed color of the theme
  //If light theme its black and if dark theme its white
  focusColor: whiteColor,
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff021821), elevation: 0, centerTitle: false),
  inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      hintStyle: Get.textTheme.bodySmall!
          .copyWith(fontSize: 14, color: whiteColor.withOpacity(0.4)),
      filled: true,
      fillColor: const Color(0xff021821),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fixedBorderRadius),
          borderSide: BorderSide.none)),
);
