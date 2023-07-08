import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/cars/get_car_cylinder.dart';
import '../../../models/car.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/text_field_container.dart';
import '../../../../ui_manager/fixed_numbers_manager.dart';

///Car cylinders text field that shows up on adding or updating a car

class CarCylinderTextField extends StatelessWidget {
  const CarCylinderTextField({super.key});

  @override
  Widget build(BuildContext context) {
    Car carVars = Get.put(Car());
    return TextFieldContainer(
      child: GetX<Car>(
          init: Car(),
          builder: (content) {
            return Column(
              children: [
                Obx(() => carVars.isSearchingForCarCylinder.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: fixedMainPadding),
                        child: SizedBox(
                            height: 1,
                            child: LinearProgressIndicator(
                              color: primaryColor,
                            )),
                      )
                    : Container()),
                TextField(
                  controller:
                      content.carCylinderController["controller"]!.value,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Car Cylinder".tr,
                      suffixIcon: InkWell(
                        onTap: () {
                          content.isSearchingForCarCylinder.value =
                              !content.isSearchingForCarCylinder.value;
                          if (content.isSearchingForCarCylinder.value) {
                            getCarCylinders(
                                modelId:
                                    content.carModelController["id"]!.value);
                          }
                        },
                        child: Icon(
                          content.isSearchingForCarCylinder.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 24,
                        ),
                      )),
                  style: Get.textTheme.bodyMedium,
                  onTap: () {
                    if (!content.isSearchingForCarCylinder.value) {
                      content.isSearchingForCarCylinder.value = true;
                    }
                    getCarCylinders(
                        modelId: content.carModelController["id"]!.value);
                  },
                  onChanged: (v) async {
                    if (!content.isSearchingForCarCylinder.value) {
                      content.isSearchingForCarCylinder.value = true;
                    }
                    getCarCylinders(
                        modelId: content.carModelController["id"]!.value);
                  },
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: content.isSearchingForCarCylinder.value
                        ? content.specificResForCarCylinders.length * 43
                        : 0,
                    child: ListView.builder(
                        itemCount: content.specificResForCarCylinders.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              content.carCylinderController["controller"]!
                                      .value!.text =
                                  content.specificResForCarCylinders[index]
                                          ["name"]!
                                      .toString()
                                      .capitalizeFirst!;
                              content.carCylinderController["id"]!.value =
                                  content.specificResForCarCylinders[index]
                                      ["id"];
                              content.isSearchingForCarCylinder.value = false;
                              content.carCylinderController["controller"]!.value
                                      .selection =
                                  TextSelection.collapsed(
                                      offset: content
                                          .carCylinderController["controller"]!
                                          .value
                                          .text
                                          .length);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: fixedPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(content.specificResForCarCylinders[index]
                                          ["name"]!
                                      .toString()
                                      .capitalizeFirst!),
                                  fixedSizedBoxHeight,
                                  index ==
                                          content.specificResForCarCylinders
                                                  .length -
                                              1
                                      ? Container()
                                      : Divider(
                                          color: Get.theme.shadowColor,
                                          height: 0,
                                        ),
                                  fixedSizedBoxHeight,
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            );
          }),
    );
  }
}
