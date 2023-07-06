import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:sayaratech/models/which_home.dart';
import 'package:sayaratech/pages/my_reservations_screen.dart';
import 'package:sayaratech/pages/my_cars/my_cars_screen.dart';
import 'package:sayaratech/pages/profile/profile_screen.dart';
import 'package:sayaratech/ui_manager/colors_manager.dart';
import 'package:sayaratech/ui_manager/fixed_numbers_manager.dart';

import 'home_screen.dart';

class Home extends StatelessWidget {
  final WhichHome? whichHome;
  const Home({super.key, this.whichHome});

  @override
  Widget build(BuildContext context) {
    var content = Get.put(WhichHome());
    return Scaffold(
      body: Obx(() => content.whichPage.value == "Profile"
          ? ProfileScreen()
          : content.whichPage.value == "Reservations"
              ? MyReservationsScreen()
              : content.whichPage.value == "Cars"
                  ? MyCarsScreen()
                  : HomeScreen()),
      bottomNavigationBar: GetX<WhichHome>(builder: (content) {
        return Container(
          height: 80,
          decoration: BoxDecoration(color: Get.theme.cardColor, boxShadow: [
            BoxShadow(
                color: Get.theme.shadowColor,
                offset: const Offset(0, -0.1),
                blurRadius: fixedBlurForShadow,
                blurStyle: BlurStyle.inner)
          ]),
          child: SafeArea(
            child: Row(
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
                        Expanded(
                          flex: 2,
                          child: content.whichPage.value == "HomeScreen"
                              ? Icon(
                                  Icons.home,
                                  color: primaryColor,
                                  size: 24,
                                )
                              : Icon(
                                  Icons.home_outlined,
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.3),
                                  size: 22,
                                ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Home",
                            style: content.whichPage.value == "HomeScreen"
                                ? Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold)
                                : Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.4)),
                          ),
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
                        Expanded(
                          flex: 2,
                          child: content.whichPage.value == "Reservations"
                              ? Icon(
                                  Icons.departure_board,
                                  color: primaryColor,
                                  size: 24,
                                )
                              : Icon(
                                  Icons.departure_board_outlined,
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.3),
                                  size: 22,
                                ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Reservations",
                            style: content.whichPage.value == "Reservations"
                                ? Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold)
                                : Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.4)),
                          ),
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
                        Expanded(
                          flex: 2,
                          child: content.whichPage.value == "Cars"
                              ? Icon(
                                  Icons.car_rental,
                                  color: primaryColor,
                                  size: 24,
                                )
                              : Icon(
                                  Icons.car_rental_outlined,
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.3),
                                  size: 22,
                                ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Cars",
                            style: content.whichPage.value == "Cars"
                                ? Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold)
                                : Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.4)),
                          ),
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
                        Expanded(
                          flex: 2,
                          child: content.whichPage.value == "Profile"
                              ? Icon(
                                  Icons.person,
                                  color: primaryColor,
                                  size: 24,
                                )
                              : Icon(
                                  Icons.person_outline,
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.3),
                                  size: 22,
                                ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Profile",
                            style: content.whichPage.value == "Profile"
                                ? Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold)
                                : Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.4)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
