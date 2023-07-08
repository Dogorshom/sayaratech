import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/which_home.dart';
import '../../pages/my_reservations_screen.dart';
import '../../pages/profile/profile_screen.dart';
import '../my_cars/my_cars_screen.dart';
import 'home_screen.dart';
import 'widgets/custom_bottom_app_bar.dart';

class Home extends StatelessWidget {
  final WhichHome? whichHome;
  const Home({super.key, this.whichHome});

  @override
  Widget build(BuildContext context) {
    var content = Get.put(WhichHome());
    return Scaffold(
        body: Obx(() => content.whichPage.value == "Profile"
            ? const ProfileScreen()
            : content.whichPage.value == "Reservations"
                ? const MyReservationsScreen()
                : content.whichPage.value == "Cars"
                    ? const MyCarsScreen()
                    : const HomeScreen()),
        bottomNavigationBar: const CustomBottomAppBar());
  }
}
