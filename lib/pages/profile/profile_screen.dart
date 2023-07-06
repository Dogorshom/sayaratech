import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/authentication/logout.dart';
import '../../../models/authentication.dart';
import '../../pages/profile/sub_pages/edit_profile_screen.dart';
import '../../pages/profile/sub_pages/settings_screen.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/profile_single_row.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                        color: Theme.of(context).scaffoldBackgroundColor,
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
                                "Edit Profile",
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
                                        Share.share(
                                            "Use this code (193nHaa8) in Sayara Tech, download the app here https://dogorshom.com",
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
                                          "Give this code to you friends\ntake your reward",
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
                                                          // ScaffoldMessenger.of(
                                                          //         context)
                                                          //     .showSnackBar(SnackBar(
                                                          //         content: Text(
                                                          //             "Code Copied")));
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
                                Text("Profile"),
                                SingleProfileRow(
                                  icon: const Icon(Icons.article_outlined),
                                  title: "Reservations & Bills",
                                  onTap: () async {
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    print(sharedPreferences
                                        .getInt("customer_id")!);
                                    print(sharedPreferences
                                        .getString("customer_name")!);
                                    print(sharedPreferences
                                        .getString("customer_username")!);
                                    print(sharedPreferences
                                        .getString("customer_email")!);
                                    print(sharedPreferences
                                        .getDouble("customer_wallet_balance")!);
                                    print(sharedPreferences.getInt(
                                        "customer_number_of_active_cars")!);
                                    print(sharedPreferences
                                        .getString("customer_phone")!);
                                    print(sharedPreferences
                                        .getString("customer_latest_token")!);
                                  },
                                ),
                                SingleProfileRow(
                                  icon: const Icon(Icons.car_rental_outlined),
                                  title: "My Cars",
                                  onTap: () {
                                    print(authVars.bearerToken);
                                  },
                                ),
                                SingleProfileRow(
                                  icon: const Icon(Icons.settings),
                                  title: "Settings",
                                  onTap: () {
                                    Get.to(() => const SettingsScreen());
                                  },
                                ),
                                SingleProfileRow(
                                  icon: const Icon(Icons.logout),
                                  title: "Logout",
                                  divider: false,
                                  onTap: () async {
                                    await logout();
                                    // getCustomerProfile();
                                  },
                                ),
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
