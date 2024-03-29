import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/cars/delete_car.dart';
import '../../../models/car.dart';
import '../../../pages/my_cars/add_or_update_cars_screen.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/buttons/custom_button.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final int carIndexInList;
  const CarCard({
    super.key,
    required this.car,
    required this.carIndexInList,
  });

  @override
  Widget build(BuildContext context) {
    Car carLoadingProcess = Get.put(Car());
    return Container(
      // height: Get.height * 0.2,
      width: Get.width,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(fixedBorderRadius),
          border: Border.all(color: blackColor.withOpacity(0.2))),
      child: Padding(
        padding: const EdgeInsets.only(
            left: fixedPadding * 2,
            right: fixedPadding * 2,
            top: fixedPadding * 2),
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
                InkWell(
                    onTap: () {
                      deleteCar(carId: car.carId!, indexInList: carIndexInList);
                    },
                    child: Text("Delete".tr)),
                CustomButton(
                  text: "Update".tr,
                  onTap: () {
                    setCarValuesForUpdate(car: car);
                    Get.to(() => AddOrUpdateCarsScreen(
                          isUpdate: true,
                          carIdForUpdate: car.carId,
                        ));
                  },
                  width: Get.width * 0.3,
                )
              ],
            ),
            fixedSizedBoxHeight,
            fixedSizedBoxHeight,
            Obx(() => carLoadingProcess.isLoading.value
                ? LinearProgressIndicator(
                    color: primaryColor,
                    backgroundColor: secondaryColor,
                  )
                : Container())
          ],
        ),
      ),
    );
  }
}

Widget getCarIcon(String carVendor) {
  if (carVendor == "Hyundai" || carVendor == "هيونداي") {
    return Image.asset(
      "assets/Icons/icons8-hyundai-400.png",
      height: 30,
    );
  }
  if (carVendor == "Ford" || carVendor == "فورد") {
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

setCarValuesForUpdate({required Car car}) {
  Car addCarVars = Get.put(Car());
  addCarVars.carVendorController["controller"]!.value.text = car.carVendorName;
  addCarVars.carVendorController["id"]!.value = car.carVendorId;
  addCarVars.carModelController["controller"]!.value.text = car.carModel;
  addCarVars.carModelController["id"]!.value = car.carModelId;
  addCarVars.carColorsController["controller"]!.value.text = car.carColor;
  addCarVars.carColorsController["id"]!.value = car.carColorId;
  addCarVars.carFuelController["controller"]!.value.text = car.carFuel;
  addCarVars.carFuelController["id"]!.value = car.carFuelId;
  // addCarVars.carCylinderController["controller"]!.value.text = car.carFuel;
  // addCarVars.carCylinderController["id"]!.value = car.carCylinderController;
  addCarVars.carProductionDateController.value.text =
      car.carProductionDate ?? "";
  addCarVars.carPlateNumberController.value.text = car.carPlateNumber ?? "";
  addCarVars.carPlateCharactersController.value.text =
      car.carPlateCharacters ?? "";
  addCarVars.licenseNumberController.value.text = car.carLicenseNumber ?? "";
}
