import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/controllers/cars/get_car_cylinder.dart';
import 'package:sayaratech/controllers/cars/get_cars_models.dart';
import 'package:sayaratech/models/car.dart';
import 'package:sayaratech/ui_manager/sized_box_manager.dart';
import 'package:sayaratech/ui_manager/widgets/text_field_container.dart';

import '../../../controllers/cars/get_cars_vendors.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';

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
                    ? const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: fixedMainPadding),
                        child: SizedBox(
                            height: 1, child: LinearProgressIndicator()),
                      )
                    : Container()),
                TextField(
                  controller:
                      content.carCylinderController["controller"]!.value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Car Cylinder: 4, 5, ..",
                      suffixIcon: InkWell(
                        onTap: () {
                          content.isSearchingForCarCylinder.value =
                              !content.isSearchingForCarCylinder.value;
                          if (content.isSearchingForCarCylinder.value) {
                            getAllCarCylinders(
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
                    print("This is passed");
                    print(content.carModelController["id"]!.value.toString());
                    getAllCarCylinders(
                        modelId: content.carModelController["id"]!.value);
                  },
                  onChanged: (v) async {
                    if (!content.isSearchingForCarCylinder.value) {
                      content.isSearchingForCarCylinder.value = true;
                    }
                    getAllCarCylinders(
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
                          print("object");
                          print(content.specificResForCarCylinders.length
                              .toString());
                          return InkWell(
                            onTap: () {
                              content.carCylinderController["controller"]!
                                      .value!.text =
                                  content.specificResForCarCylinders[index]
                                          ["name"]!
                                      .toString()
                                      .capitalizeFirst!;

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
                                          color: Theme.of(context).shadowColor,
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
