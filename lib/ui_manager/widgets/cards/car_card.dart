import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sayaratech/models/car.dart';
import 'package:sayaratech/pages/my_cars/add_cars_screen.dart';
import 'package:sayaratech/ui_manager/colors_manager.dart';
import 'package:sayaratech/ui_manager/fixed_numbers_manager.dart';
import 'package:sayaratech/ui_manager/sized_box_manager.dart';
import 'package:sayaratech/ui_manager/widgets/buttons/custom_button.dart';

class CarCard extends StatelessWidget {
  final Car car;
  const CarCard({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Get.height * 0.2,
      width: Get.width,
      decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(fixedBorderRadius),
          border: Border.all(color: blackColor.withOpacity(0.2))),
      child: Padding(
        padding: const EdgeInsets.all(fixedPadding * 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCarIcon(car.carVendorName ?? "Kia"),
                Text(car.carVendorName ?? "Not Specified")
              ],
            ),
            fixedSizedBoxHeight,
            fixedSmallSizedBoxHeight,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: fixedPadding * 2),
              child: Container(
                height: Get.height * 0.05,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(fixedBorderRadius),
                  border: Border.all(color: secondaryColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset("assets/Icons/saudi_icon.png"),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(car.carPlateNumber ?? "-"),
                        Text(" ${car.carPlateCharacters ?? ""}")
                      ],
                    )),
                    //This icon just for balance
                    const Icon(
                      Icons.abc,
                      color: Colors.transparent,
                    )
                  ],
                ),
              ),
            ),
            fixedSizedBoxHeight,
            fixedSmallSizedBoxHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(onTap: () {}, child: const Text("Delete")),
                CustomButton(
                  text: "Update",
                  onTap: () {
                    Car carVars = Get.put(Car());
                    carVars.carVendorController["controller"]!.value.text =
                        car.carVendorName ?? "";
                    carVars.carFuelController.value.text = car.carFuel ?? "";
                    carVars.serialNumberController.value.text =
                        car.carSerialNumber ?? "";
                    carVars.carPlateNumberController.value.text =
                        car.carPlateNumber ?? "";
                    carVars.carPlateCharactersController.value.text =
                        car.carPlateCharacters ?? "";
                    carVars.availableColorsController.value.text =
                        car.carColor ?? "";
                    carVars.dateOfProductionController.value.text =
                        car.carProductionDate ?? "";
                    Get.to(() => AddCarsScreen(
                          isUpdate: true,
                          idForUpdate: car.carId,
                        ));
                  },
                  width: Get.width * 0.3,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget getCarIcon(String carType) {
  if (carType == "Hyundai") {
    return Image.asset(
      "assets/Icons/icons8-hyundai-400.png",
      height: 30,
    );
  }
  if (carType == "Kia") {
    return Image.asset(
      "assets/Icons/icons8-kia-480.png",
      height: 30,
    );
  }
  if (carType == "Ford") {
    return Image.asset(
      "assets/Icons/icons8-ford-480.png",
      height: 30,
    );
  }
  return Image.asset(
    "assets/Icons/sayarahtech_logo.png",
    height: 30,
  );
}
