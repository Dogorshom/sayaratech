import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cars/get_cars.dart';
import 'add_or_update_cars_screen.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/buttons/custom_button.dart';
import '../../../ui_manager/widgets/cards/car_card.dart';
import '../../../models/car.dart';

class MyCarsScreen extends StatelessWidget {
  const MyCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Car());
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.height * 0.2,
            width: Get.width,
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(fixedBorderRadius * 3),
                    bottomRight: Radius.circular(fixedBorderRadius * 3))),
            child: Stack(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      onPressed: () {
                        //reset all data
                        Get.delete<Car>();
                        Get.put(Car()).isRunGetCarsFunction.value = true;
                        Get.to(() => const AddOrUpdateCarsScreen());
                      },
                      icon: Icon(
                        Icons.add_circle_outline_rounded,
                        size: 40,
                        color: whiteColor,
                      )),
                ),
                Center(
                  child: Text(
                    "My Cars".tr,
                    style: TextStyle(
                        fontSize: 24,
                        color: whiteColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetX<Car>(
                // init: Car(),
                builder: (content) {
              if (!content.isRunGetCarsFunction.value) {
                getCars();
                return Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                  backgroundColor: secondaryColor,
                ));
              }
              if (content.carsList.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have cars".tr,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyLarge,
                    ),
                    fixedSizedBoxHeight,
                    fixedSizedBoxHeight,
                    CustomButton(
                      text: "Add Car".tr,
                      onTap: () {
                        //reset all data
                        Get.delete<Car>();
                        Get.put(Car()).isRunGetCarsFunction.value = true;
                        Get.to(() => const AddOrUpdateCarsScreen());
                      },
                    )
                  ],
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: fixedMainPadding * 2),
                  child: ListView.builder(
                      itemCount: content.carsList.length,
                      itemBuilder: ((_, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: fixedPadding),
                          child: CarCard(
                            car: content.carsList[index],
                            carIndexInList: index,
                          ),
                        );
                      })),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
