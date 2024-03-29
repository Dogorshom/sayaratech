import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/car.dart';
import '../../../ui_manager/extensions_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/text_field_container.dart';

import '../../../controllers/cars/get_car_colors.dart';
import '../../../../ui_manager/fixed_numbers_manager.dart';

///Car colors text field that shows up on adding or updating a car
class CarColorsTextField extends StatelessWidget {
  const CarColorsTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: GetX<Car>(
          init: Car(),
          builder: (content) {
            return Column(
              children: [
                TextField(
                  controller: content.carColorsController["controller"]!.value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Car Color".tr,
                      suffixIcon: InkWell(
                        onTap: () {
                          content.scrollController.value.animateTo(
                              Get.height * 0.3,
                              curve: Curves.easeOut,
                              duration: const Duration(seconds: 1));
                          content.isSearchingForCarColors.value =
                              !content.isSearchingForCarColors.value;
                          if (content.isSearchingForCarColors.value) {
                            getCarColors();
                          }
                        },
                        child: Icon(
                          content.isSearchingForCarColors.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 24,
                        ),
                      )),
                  style: Get.textTheme.bodyMedium,
                  onTap: () {
                    if (!content.isSearchingForCarColors.value) {
                      content.isSearchingForCarColors.value = true;
                    }
                    content.scrollController.value.animateTo(Get.height * 0.2,
                        curve: Curves.easeOut,
                        duration: const Duration(seconds: 1));
                    getCarColors();
                  },
                  onChanged: (v) async {
                    if (!content.isSearchingForCarColors.value) {
                      content.isSearchingForCarColors.value = true;
                    }
                    getCarColors();
                  },
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: content.isSearchingForCarColors.value
                        ? content.specificResForCarColors.length * 43
                        : 0,
                    child: ListView.builder(
                        itemCount: content.specificResForCarColors.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              content.carColorsController["controller"]!.value
                                  .text = content.specificResForCarColors[index]
                                      ["name"]!
                                  .toString()
                                  .firstLetterCapitalize();
                              content.carColorsController["id"]!.value =
                                  content.specificResForCarColors[index]["id"];
                              content.isSearchingForCarColors.value = false;
                              content.carColorsController["controller"]!.value
                                      .selection =
                                  TextSelection.collapsed(
                                      offset: content
                                          .carColorsController["controller"]!
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
                                  Text(content.specificResForCarColors[index]
                                          ["name"]!
                                      .toString()
                                      .firstLetterCapitalize()),
                                  fixedSizedBoxHeight,
                                  index ==
                                          content.specificResForCarColors
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
