import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cars/get_one_car.dart';
import '../../../models/car.dart';
import '../../controllers/cars/add_or_update_car.dart';
import 'widgets/available_color_text_field.dart';
import 'widgets/car_cylinder_text_field.dart';
import 'widgets/car_fuel_type.dart';
import 'widgets/car_model_text_field.dart';
import 'widgets/car_vendors_text_field.dart';
import 'widgets/date_of_production.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/buttons/custom_button.dart';
import '../../../ui_manager/widgets/text_field_container.dart';
import '../../../ui_manager/widgets/overlays/loading_overlay.dart';

class AddOrUpdateCarsScreen extends StatelessWidget {
  final bool? isUpdate;
  final int? carIdForUpdate;
  const AddOrUpdateCarsScreen(
      {super.key, this.isUpdate = false, this.carIdForUpdate});

  @override
  Widget build(BuildContext context) {
    var addCarVariables = Get.put(Car());
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              isUpdate! ? "Update Car" : "Add Car",
              style: Get.textTheme.titleLarge!.copyWith(color: primaryColor),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.home_outlined)),
              carIdForUpdate != null
                  ? IconButton(
                      onPressed: () async {
                        await getOneCarDetails(carId: carIdForUpdate!);
                      },
                      icon: Icon(
                        Icons.details_rounded,
                        color: primaryColor,
                      ))
                  : Container()
            ],
          ),
          body: Container(
            height: Get.height,
            width: Get.width,
            color: Get.theme.scaffoldBackgroundColor,
            child: SingleChildScrollView(
              controller: addCarVariables.scrollController.value,
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (addCarVariables.isSearchingForCarVendor.value) {
                    addCarVariables.isSearchingForCarVendor.value = false;
                  }
                  if (addCarVariables.isSearchingForCarFuel.value) {
                    addCarVariables.isSearchingForCarFuel.value = false;
                  }
                  if (addCarVariables.isSearchingForCarColors.value) {
                    addCarVariables.isSearchingForCarColors.value = false;
                  }
                  if (addCarVariables.isSearchingForDateOfProduction.value) {
                    addCarVariables.isSearchingForDateOfProduction.value =
                        false;
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixedMainPadding),
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
                              addCarVariables.licenseNumberController.value,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Car License Number",
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
                              keyboardType: TextInputType.number,
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
                              keyboardType: TextInputType.text,
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
                              await addOrUpdateCar(
                                  idForUpdate: carIdForUpdate!);
                            } else {
                              await addOrUpdateCar();
                            }
                          },
                          text: isUpdate != null && isUpdate == true
                              ? "Update"
                              : "Confirm"),
                      fixedSizedBoxHeight,
                      fixedSizedBoxHeight,
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
