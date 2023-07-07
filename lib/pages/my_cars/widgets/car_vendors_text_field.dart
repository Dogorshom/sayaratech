import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../models/car.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/text_field_container.dart';
import '../../../controllers/cars/get_cars_vendors.dart';
import '../../../../ui_manager/fixed_numbers_manager.dart';

class CarVendorTextField extends StatelessWidget {
  final String? initData;
  const CarVendorTextField({super.key, this.initData});

  @override
  Widget build(BuildContext context) {
    Car carVars = Get.put(Car());
    return TextFieldContainer(
      child: GetX<Car>(
          init: Car(),
          builder: (content) {
            return Column(
              children: [
                Obx(() => carVars.isSearchingForCarVendor.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: fixedMainPadding),
                        child: SizedBox(
                          height: 1,
                          child: LinearProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      )
                    : Container()),
                TextField(
                  controller: content.carVendorController["controller"]!.value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: initData ?? "Car Vendor".tr,
                      suffixIcon: InkWell(
                        onTap: () {
                          content.carVendorController["controller"]!.value
                              .text = "";
                          content.carModelController["controller"]!.value.text =
                              "";
                          content.carCylinderController["controller"]!.value
                              .text = "";
                          content.isSearchingForCarVendor.value =
                              !content.isSearchingForCarVendor.value;
                          if (content.isSearchingForCarVendor.value) {
                            getAllCarVendors();
                          }
                        },
                        child: Icon(
                          content.isSearchingForCarVendor.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 24,
                        ),
                      )),
                  style: Get.textTheme.bodyMedium,
                  onTap: () {
                    content.carVendorController["controller"]!.value.text = "";
                    content.carModelController["controller"]!.value.text = "";
                    content.carCylinderController["controller"]!.value.text =
                        "";

                    if (!content.isSearchingForCarVendor.value) {
                      content.isSearchingForCarVendor.value = true;
                    }
                    getAllCarVendors();
                  },
                  onChanged: (v) async {
                    if (!content.isSearchingForCarVendor.value) {
                      content.isSearchingForCarVendor.value = true;
                    }
                    getAllCarVendors();
                    content.carModelController["controller"]!.value.text = "";
                    content.carCylinderController["controller"]!.value.text =
                        "";
                  },
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: AnimatedContainer(
                    duration: Duration(
                        milliseconds:
                            content.isSearchingForCarVendor.value ? 4000 : 100),
                    height: content.isSearchingForCarVendor.value
                        ? content.specificResForCarVendors.length * 43
                        : 0,
                    child: ListView.builder(
                        itemCount: content.specificResForCarVendors.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              content.carVendorController["controller"]!.value
                                      .text =
                                  content.specificResForCarVendors[index]
                                          ["name"]!
                                      .toString()
                                      .capitalizeFirst!;
                              print("This is chossen");
                              print(content.specificResForCarVendors[index]
                                  ["id"]!);
                              content.carVendorController["id"]!.value = content
                                  .specificResForCarVendors[index]["id"]!;
                              content.isSearchingForCarVendor.value = false;
                              content.carVendorController["controller"]!.value
                                      .selection =
                                  TextSelection.collapsed(
                                      offset: content
                                          .carVendorController["controller"]!
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
                                  Text(content.specificResForCarVendors[index]
                                          ["name"]!
                                      .toString()
                                      .capitalizeFirst!),
                                  fixedSizedBoxHeight,
                                  index ==
                                          content.specificResForCarVendors
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
