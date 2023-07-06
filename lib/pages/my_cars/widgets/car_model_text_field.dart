import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/controllers/cars/get_cars_models.dart';
import 'package:sayaratech/models/car.dart';
import 'package:sayaratech/ui_manager/sized_box_manager.dart';
import 'package:sayaratech/ui_manager/widgets/text_field_container.dart';

import '../../../controllers/cars/get_cars_vendors.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';

class CarModelTextField extends StatelessWidget {
  const CarModelTextField({super.key});

  @override
  Widget build(BuildContext context) {
    Car carVars = Get.put(Car());
    return TextFieldContainer(
      child: GetX<Car>(
          init: Car(),
          builder: (content) {
            return Column(
              children: [
                Obx(() => carVars.isSearchingForCarModel.value
                    ? const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: fixedMainPadding),
                        child: SizedBox(
                            height: 1, child: LinearProgressIndicator()),
                      )
                    : Container()),
                TextField(
                  controller: content.carModelController["controller"]!.value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Car Model: sonata, tucson, ..",
                      suffixIcon: InkWell(
                        onTap: () {
                          content.isSearchingForCarModel.value =
                              !content.isSearchingForCarModel.value;
                          if (content.isSearchingForCarModel.value) {
                            getAllCarModels(
                                vendorIdForUrl:
                                    content.carVendorController["id"]!.value);
                          }
                        },
                        child: Icon(
                          content.isSearchingForCarModel.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 24,
                        ),
                      )),
                  style: Get.textTheme.bodyMedium,
                  onTap: () {
                    if (!content.isSearchingForCarModel.value) {
                      content.isSearchingForCarModel.value = true;
                    }
                    print("This is passed");
                    print(content.carVendorController["id"]!.value.toString());
                    getAllCarModels(
                        vendorIdForUrl:
                            content.carVendorController["id"]!.value);
                  },
                  onChanged: (v) async {
                    if (!content.isSearchingForCarModel.value) {
                      content.isSearchingForCarModel.value = true;
                    }
                    getAllCarModels(
                        vendorIdForUrl:
                            content.carVendorController["id"]!.value);
                    content.carCylinderController["controller"]!.value.text =
                        "";
                  },
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: content.isSearchingForCarModel.value
                        ? content.specificResForCarModels.length * 43
                        : 0,
                    child: ListView.builder(
                        itemCount: content.specificResForCarModels.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              content.carModelController["controller"]!.value!
                                  .text = content.specificResForCarModels[index]
                                      ["name"]!
                                  .toString()
                                  .capitalizeFirst!;
                              content.carModelController["id"]!.value = content
                                  .specificResForCarModels[index]["id"]!
                                  .toString();
                              content.isSearchingForCarModel.value = false;
                              content.carModelController["controller"]!.value
                                      .selection =
                                  TextSelection.collapsed(
                                      offset: content
                                          .carModelController["controller"]!
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
                                  Text(content.specificResForCarModels[index]
                                          ["name"]!
                                      .toString()
                                      .capitalizeFirst!),
                                  fixedSizedBoxHeight,
                                  index ==
                                          content.specificResForCarModels
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
