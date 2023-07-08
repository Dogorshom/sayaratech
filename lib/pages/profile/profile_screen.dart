import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sayaratech/controllers/cars/get_cars.dart';
import 'package:sayaratech/models/which_home.dart';
import 'package:sayaratech/pages/home/home.dart';
import '../../../models/authentication.dart';
import '../../pages/profile/sub_pages/edit_profile_screen.dart';
import '../../pages/profile/sub_pages/settings_screen.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/profile_single_row.dart';
import 'package:share_plus/share_plus.dart';

import '../../ui_manager/widgets/overlays/logout_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Authentication authVars = Get.put(Authentication());
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixedMainPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 40,
                          color: whiteColor,
                        ),
                        Image.asset(
                          "assets/Icons/sayarahtech_logo.png",
                          height: 50,
                          color: whiteColor,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Expanded(
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Get.theme.scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(fixedBorderRadius * 5),
                            topRight: Radius.circular(fixedBorderRadius * 5))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.1,
                          ),
                          Text(
                            authVars.name.value,
                            style: Get.textTheme.headlineSmall,
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(() => const EditProfileScreen());
                              },
                              child: Text(
                                "Edit Profile".tr,
                                style: Get.textTheme.titleSmall!
                                    .copyWith(color: primaryColor),
                              )),
                          fixedSizedBoxHeight,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: fixedMainPadding),
                            child: Container(
                              padding: const EdgeInsets.all(fixedPadding),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      fixedBorderRadius * 2),
                                  border:
                                      Border.all(color: Get.theme.shadowColor)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {
                                        final box = context.findRenderObject()
                                            as RenderBox?;
                                        Share.share("Use this code".tr,
                                            sharePositionOrigin: box!
                                                    .localToGlobal(
                                                        Offset.zero) &
                                                box.size);
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Give code for friends sentence".tr,
                                          textAlign: TextAlign.center,
                                          style: Get.textTheme.titleSmall,
                                        ),
                                        fixedSizedBoxHeight,
                                        fixedSizedBoxHeight,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: fixedPadding),
                                          child: DottedBorder(
                                            color: Colors.grey.shade600,
                                            strokeWidth: 2,
                                            radius: const Radius.circular(
                                                fixedBorderRadius * 2),
                                            borderType: BorderType.RRect,
                                            // strokeCap: StrokeCap.round,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    fixedPadding),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Clipboard.setData(
                                                                const ClipboardData(
                                                                    text:
                                                                        "193nHaa8"))
                                                            .then((_) {
                                                          Get.snackbar(
                                                              "Code Copied",
                                                              "193nHaa8",
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          2));
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.copy_rounded,
                                                        color: primaryColor,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Center(
                                                            child: Text(
                                                      "193nHaa8",
                                                      style: Get.textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ))),
                                                    //This icon just for balance
                                                    const Icon(Icons.wb_sunny,
                                                        color:
                                                            Colors.transparent),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        fixedSizedBoxHeight,
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          fixedSizedBoxHeight,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: fixedMainPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Personal Profile".tr),
                                SingleProfileRow(
                                  icon: const Icon(Icons.article_outlined),
                                  title: "Reservations & Bills".tr,
                                  onTap: () async {},
                                ),
                                SingleProfileRow(
                                  icon: const Icon(Icons.car_rental_outlined),
                                  title: "My Cars".tr,
                                  onTap: () async {
                                    await getCars();
                                    Get.put(WhichHome()).whichPage.value =
                                        "Cars";
                                    Get.to(() => Home(
                                          whichHome: Get.put(WhichHome()),
                                        ));
                                  },
                                ),
                                SingleProfileRow(
                                  icon: const Icon(Icons.settings_outlined),
                                  title: "Settings".tr,
                                  onTap: () {
                                    Get.to(() => const SettingsScreen());
                                  },
                                ),
                                SingleProfileRow(
                                  icon: const Icon(Icons.location_on_outlined),
                                  title: "Addresses".tr,
                                  onTap: () {},
                                ),
                                SingleProfileRow(
                                  icon: const Icon(Icons.money),
                                  title: "CashBack".tr,
                                  onTap: () {},
                                ),
                                SingleProfileRow(
                                  icon: const Icon(Icons.logout),
                                  title: "Logout".tr,
                                  divider: false,
                                  onTap: () async {
                                    await logoutDialog();
                                  },
                                ),
                                fixedSizedBoxHeight,
                                fixedSizedBoxHeight,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Get.height * 0.14,
                    width: Get.height * 0.14,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey.shade300),
                    child: Center(
                      child: Text(
                        authVars.name.value.substring(0, 1).toUpperCase(),
                        style: Get.textTheme.headlineLarge!
                            .copyWith(color: primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
