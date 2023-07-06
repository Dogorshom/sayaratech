import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/car.dart';
import '../../../ui_manager/extensions_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/text_field_container.dart';

import '../../../controllers/cars/get_car_colors.dart';
import '../../../../ui_manager/fixed_numbers_manager.dart';

class AvailableColorsTextField extends StatelessWidget {
  const AvailableColorsTextField({super.key});

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
                      hintText: "Color: black, red, white..",
                      suffixIcon: InkWell(
                        onTap: () {
                          content.isSearchingForCarColors.value =
                              !content.isSearchingForCarColors.value;
                          if (content.isSearchingForCarColors.value) {
                            getAllColorsAvailable();
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
                    getAllColorsAvailable();
                  },
                  onChanged: (v) async {
                    if (!content.isSearchingForCarColors.value) {
                      content.isSearchingForCarColors.value = true;
                    }
                    getAllColorsAvailable();
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
