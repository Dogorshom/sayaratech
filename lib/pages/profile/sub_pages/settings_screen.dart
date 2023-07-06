import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/ui_manager/widgets/profile_single_row.dart';

import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/themes/dark_theme.dart';
import '../../../ui_manager/themes/light_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).shadowColor,
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
                        title: 'Language',
                        automaticallyTailButton: false,
                        tail: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (Get.locale != const Locale("en", "US")) {
                                  Get.updateLocale(const Locale("en", "US"));
                                }
                              },
                              child: Text(
                                "En",
                                style: Get.locale == const Locale("en", "US")
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            fixedSizedBoxWidth,
                            fixedSizedBoxWidth,
                            InkWell(
                              onTap: () {
                                if (Get.locale != const Locale("ar", "SD")) {
                                  Get.updateLocale(const Locale("ar", "SD"));
                                }
                              },
                              child: Text(
                                "Ar",
                                style: Get.locale != const Locale("en", 'US')
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.bodySmall,
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
                        title: 'Dark Mode',
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
                                Theme.of(context).focusColor.withOpacity(0.5),
                            onChanged: (isDarkMode) {
                              if (Get.isDarkMode) {
                                Get.changeTheme(lightThemeData);
                              } else {
                                Get.changeTheme(darkThemeData);
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
                        title: 'Privacy Policy',
                        divider: false,
                        automaticallyTailButton: false,
                      ),
                    ],
                  ),
                ),
                fixedSizedBoxHeight,
                fixedSizedBoxHeight,
                Container(
                  padding: EdgeInsets.all(fixedPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(fixedBorderRadius),
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).shadowColor,
                            offset: const Offset(0, 1),
                            blurRadius: fixedBlurForShadow)
                      ]),
                  child: SingleProfileRow(
                    onTap: () {},
                    icon: Icon(
                      Icons.delete,
                      color: redColor,
                    ),
                    title: 'Delete Account',
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
