import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/which_home.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';

///The main bottom app bar
class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var content = Get.put(WhichHome());
    return Obx(
      () => Container(
        height: 70,
        alignment: Alignment.bottomCenter,
        decoration:
            BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [
          BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: const Offset(0, -0.1),
              blurRadius: fixedBlurForShadow,
              blurStyle: BlurStyle.inner)
        ]),
        child: Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      content.whichPage.value = "HomeScreen";
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        content.whichPage.value == "HomeScreen"
                            ? Icon(
                                Icons.home,
                                color: primaryColor,
                                size: 22,
                              )
                            : Icon(
                                Icons.home_outlined,
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.3),
                                size: 20,
                              ),
                        Text(
                          "Home".tr,
                          style: content.whichPage.value == "HomeScreen"
                              ? Get.textTheme.bodySmall!.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500)
                              : Get.textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.4)),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      content.whichPage.value = "Reservations";
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        content.whichPage.value == "Reservations"
                            ? Icon(
                                Icons.departure_board,
                                color: primaryColor,
                                size: 22,
                              )
                            : Icon(
                                Icons.departure_board_outlined,
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.3),
                                size: 20,
                              ),
                        Text(
                          "Reservations".tr,
                          style: content.whichPage.value == "Reservations"
                              ? Get.textTheme.bodySmall!.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500)
                              : Get.textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.4)),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      content.whichPage.value = "Cars";
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        content.whichPage.value == "Cars"
                            ? Icon(
                                Icons.car_rental,
                                color: primaryColor,
                                size: 22,
                              )
                            : Icon(
                                Icons.car_rental_outlined,
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.3),
                                size: 20,
                              ),
                        Text(
                          "Cars".tr,
                          style: content.whichPage.value == "Cars"
                              ? Get.textTheme.bodySmall!.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500)
                              : Get.textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.4)),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      content.whichPage.value = "Profile";
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        content.whichPage.value == "Profile"
                            ? Icon(
                                Icons.person,
                                color: primaryColor,
                                size: 22,
                              )
                            : Icon(
                                Icons.person_outline,
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.3),
                                size: 20,
                              ),
                        Text(
                          "Profile".tr,
                          style: content.whichPage.value == "Profile"
                              ? Get.textTheme.bodySmall!.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500)
                              : Get.textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.4)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
