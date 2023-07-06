import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/models/car.dart';
import 'package:sayaratech/ui_manager/sized_box_manager.dart';
import 'package:sayaratech/ui_manager/widgets/text_field_container.dart';

import '../../../ui_manager/fixed_numbers_manager.dart';

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
                  controller: content.availableColorsController.value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Color: black, red, white..",
                      suffixIcon: InkWell(
                        onTap: () {
                          content.isSearchingForAvailableColors.value =
                              !content.isSearchingForAvailableColors.value;
                          if (content.isSearchingForAvailableColors.value) {
                            content.getAllColorsAvailable();
                          }
                        },
                        child: Icon(
                          content.isSearchingForAvailableColors.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 24,
                        ),
                      )),
                  style: Get.textTheme.bodyMedium,
                  onTap: () {
                    if (!content.isSearchingForAvailableColors.value) {
                      content.isSearchingForAvailableColors.value = true;
                    }
                    content.getAllColorsAvailable();
                  },
                  onChanged: (v) async {
                    if (!content.isSearchingForAvailableColors.value) {
                      content.isSearchingForAvailableColors.value = true;
                    }
                    content.getAllColorsAvailable();
                  },
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: content.isSearchingForAvailableColors.value
                        ? content.specificResForAvailableColors.length * 43
                        : 0,
                    child: ListView.builder(
                        itemCount: content.specificResForAvailableColors.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              content.availableColorsController.value.text =
                                  content.specificResForAvailableColors[index]!;
                              content.isSearchingForAvailableColors.value =
                                  false;
                              content.availableColorsController.value
                                      .selection =
                                  TextSelection.collapsed(
                                      offset: content.availableColorsController
                                          .value.text.length);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: fixedPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(content
                                      .specificResForAvailableColors[index]!
                                      .capitalize!),
                                  fixedSizedBoxHeight,
                                  index ==
                                          content.specificResForAvailableColors
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
