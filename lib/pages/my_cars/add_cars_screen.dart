import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/controllers/cars/update_car.dart';
import 'package:sayaratech/models/car.dart';
import 'package:sayaratech/controllers/cars/add_car.dart';
import 'package:sayaratech/pages/my_cars/widgets/available_color.dart';
import 'package:sayaratech/pages/my_cars/widgets/car_cylinder_text_field.dart';
import 'package:sayaratech/pages/my_cars/widgets/car_fuel_type.dart';
import 'package:sayaratech/pages/my_cars/widgets/car_model_text_field.dart';
import 'package:sayaratech/pages/my_cars/widgets/car_vendors_text_field.dart';
import 'package:sayaratech/pages/my_cars/widgets/date_of_production.dart';
import 'package:sayaratech/ui_manager/colors_manager.dart';
import 'package:sayaratech/ui_manager/fixed_numbers_manager.dart';
import 'package:sayaratech/ui_manager/sized_box_manager.dart';
import 'package:sayaratech/ui_manager/widgets/buttons/custom_button.dart';
import 'package:sayaratech/ui_manager/widgets/text_field_container.dart';

import '../../ui_manager/widgets/overlays/loading_overlay.dart';

class AddCarsScreen extends StatelessWidget {
  final bool? isUpdate;
  final String? idForUpdate;
  const AddCarsScreen({super.key, this.isUpdate, this.idForUpdate});

  @override
  Widget build(BuildContext context) {
    var addCarVariables = Get.put(Car());
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Add Car",
              style: Get.textTheme.titleLarge!.copyWith(color: primaryColor),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.home_outlined))
            ],
          ),
          body: Container(
            height: Get.height,
            width: Get.width,
            color: Get.theme.scaffoldBackgroundColor,
            child: InkWell(
              onTap: () {
                if (addCarVariables.isSearchingForCarVendor.value) {
                  addCarVariables.isSearchingForCarVendor.value = false;
                }
                if (addCarVariables.isSearchingForCarFuel.value) {
                  addCarVariables.isSearchingForCarFuel.value = false;
                }
                if (addCarVariables.isSearchingForAvailableColors.value) {
                  addCarVariables.isSearchingForAvailableColors.value = false;
                }
                if (addCarVariables.isSearchingForDateOfProduction.value) {
                  addCarVariables.isSearchingForDateOfProduction.value = false;
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixedMainPadding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fixedSizedBoxHeight,
                      fixedSizedBoxHeight,
                      Text(
                        "Required Information",
                        style: Get.textTheme.titleSmall,
                      ),
                      fixedSizedBoxHeight,
                      const CarVendorTextField(),
                      fixedSizedBoxHeight,
                      const CarModelTextField(),
                      fixedSizedBoxHeight,
                      const CarCylinderTextField(),
                      fixedSizedBoxHeight,
                      const CarFuelTypeTextField(),
                      fixedSizedBoxHeight,
                      fixedSizedBoxHeight,
                      Text(
                        "Car Registeration info",
                        style: Get.textTheme.titleSmall,
                      ),
                      fixedSizedBoxHeight,
                      TextFieldContainer(
                        child: TextField(
                          controller:
                              addCarVariables.serialNumberController.value,
                          decoration: InputDecoration(
                            hintText: "Serial Number",
                            isDense: true,
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.info_outline,
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      fixedSizedBoxHeight,
                      TextFieldContainer(
                        child: Row(
                          children: [
                            Flexible(
                                child: TextField(
                              controller: addCarVariables
                                  .carPlateNumberController.value,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                hintText: "Plate Number",
                              ),
                            )),
                            Image.asset(
                              "assets/Icons/saudi_icon.png",
                              height: 30,
                            ),
                            Flexible(
                                child: TextField(
                              controller: addCarVariables
                                  .carPlateCharactersController.value,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                hintText: "Plate Characters",
                              ),
                            )),
                          ],
                        ),
                      ),
                      fixedSizedBoxHeight,
                      fixedSizedBoxHeight,
                      Text(
                        "Additional Information",
                        style: Get.textTheme.titleSmall,
                      ),
                      fixedSizedBoxHeight,
                      const AvailableColorsTextField(),
                      fixedSizedBoxHeight,
                      const DateOfProductionTextField(),
                      fixedSizedBoxHeightBy5,
                      CustomButton(
                          width: Get.width,
                          onTap: () async {
                            if (isUpdate != null && isUpdate == true) {
                              await updateOneCar(id: "32");
                            } else {
                              await addCar();
                            }
                          },
                          text: isUpdate != null && isUpdate == true
                              ? "Update"
                              : "Confirm")
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Obx(() => addCarVariables.isLoading.value
            ? const LoadingOverlay()
            : Container())
      ],
    );
  }
}
