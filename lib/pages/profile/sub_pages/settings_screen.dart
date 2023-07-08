import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/controllers/cars/get_cars.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ui_manager/widgets/profile_single_row.dart';
import '../../../../ui_manager/colors_manager.dart';
import '../../../../ui_manager/fixed_numbers_manager.dart';
import '../../../../ui_manager/sized_box_manager.dart';
import '../../../../ui_manager/themes/dark_theme.dart';
import '../../../../ui_manager/themes/light_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log(Get.locale.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings".tr,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixedMainPadding),
            child: Column(
              children: [
                fixedSizedBoxHeight,
                fixedSizedBoxHeight,
                fixedSizedBoxHeight,
                Container(
                  padding: EdgeInsets.all(fixedPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(fixedBorderRadius),
                      color: Get.theme.cardColor,
                      boxShadow: [
                        BoxShadow(
                            color: Get.theme.shadowColor,
                            offset: const Offset(0, 1),
                            blurRadius: fixedBlurForShadow)
                      ]),
                  child: Column(
                    children: [
                      SingleProfileRow(
                        icon: Icon(
                          Icons.language_outlined,
                          color: primaryColor,
                        ),
                        title: 'Language'.tr,
                        automaticallyTailButton: false,
                        tail: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                if (Get.locale != const Locale("en", "US")) {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.setBool("isArabic", false);
                                  Get.updateLocale(const Locale("en", "US"));
                                  getCars();
                                }
                              },
                              child: Text(
                                "En",
                                style: Get.locale == const Locale("en", "US")
                                    ? Get.textTheme.titleSmall
                                    : Get.textTheme.bodySmall,
                              ),
                            ),
                            fixedSizedBoxWidth,
                            fixedSizedBoxWidth,
                            InkWell(
                              onTap: () async {
                                if (Get.locale != const Locale("ar", "SA")) {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.setBool("isArabic", true);
                                  Get.updateLocale(const Locale("ar", "SA"));
                                  getCars();
                                }
                              },
                              child: Text(
                                "Ar",
                                style: Get.locale != const Locale("en", 'US')
                                    ? Get.textTheme.titleSmall
                                    : Get.textTheme.bodySmall,
                              ),
                            ),
                            fixedSizedBoxWidth,
                            fixedSizedBoxWidth,
                            fixedSizedBoxWidth,
                          ],
                        ),
                      ),
                      SingleProfileRow(
                        icon: Icon(
                          Get.isDarkMode
                              ? Icons.dark_mode
                              : Icons.dark_mode_outlined,
                          color: primaryColor,
                        ),
                        title: 'Dark Mode'.tr,
                        automaticallyTailButton: false,
                        tail: SizedBox(
                          height: 20,
                          child: Switch(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: Get.isDarkMode ? true : false,
                            activeColor: primaryColor,
                            activeTrackColor: secondaryColor,
                            inactiveTrackColor:
                                Get.theme.focusColor.withOpacity(0.5),
                            onChanged: (isDarkMode) async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();

                              if (Get.isDarkMode) {
                                Get.changeTheme(lightThemeData);
                                sharedPreferences.setBool("isDarkMode", false);
                              } else {
                                Get.changeTheme(darkThemeData);
                                sharedPreferences.setBool("isDarkMode", true);
                              }
                            },
                          ),
                        ),
                      ),
                      SingleProfileRow(
                        onTap: () {
                          // Get.to(() => const PrivacyScreen());
                        },
                        icon: Icon(
                          Icons.privacy_tip_outlined,
                          color: primaryColor,
                        ),
                        title: 'Privacy Policy'.tr,
                        divider: false,
                        automaticallyTailButton: false,
                      ),
                    ],
                  ),
                ),
                fixedSizedBoxHeight,
                fixedSizedBoxHeight,
                Container(
                  padding: const EdgeInsets.all(fixedPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(fixedBorderRadius),
                      color: Get.theme.cardColor,
                      boxShadow: [
                        BoxShadow(
                            color: Get.theme.shadowColor,
                            offset: const Offset(0, 1),
                            blurRadius: fixedBlurForShadow)
                      ]),
                  child: SingleProfileRow(
                    onTap: () async {},
                    icon: Icon(
                      Icons.delete,
                      color: redColor,
                    ),
                    title: 'Delete Account'.tr,
                    divider: false,
                    titleColor: redColor,
                    automaticallyTailButton: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
