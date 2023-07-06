import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/models/car.dart';
import 'package:sayaratech/ui_manager/sized_box_manager.dart';
import 'package:sayaratech/ui_manager/widgets/text_field_container.dart';

import '../../../ui_manager/fixed_numbers_manager.dart';

class DateOfProductionTextField extends StatelessWidget {
  const DateOfProductionTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: GetX<Car>(
          init: Car(),
          builder: (content) {
            return Column(
              children: [
                TextField(
                  controller: content.dateOfProductionController.value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Production Date: 2019, 2020, ..",
                      suffixIcon: InkWell(
                        onTap: () {
                          content.isSearchingForDateOfProduction.value =
                              !content.isSearchingForDateOfProduction.value;
                          if (content.isSearchingForDateOfProduction.value) {
                            content.getAllYears();
                          }
                        },
                        child: Icon(
                          content.isSearchingForDateOfProduction.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 24,
                        ),
                      )),
                  style: Get.textTheme.bodyMedium,
                  onTap: () {
                    if (!content.isSearchingForDateOfProduction.value) {
                      content.isSearchingForDateOfProduction.value = true;
                    }
                    content.getAllYears();
                  },
                  onChanged: (v) async {
                    if (!content.isSearchingForDateOfProduction.value) {
                      content.isSearchingForDateOfProduction.value = true;
                    }
                    content.getAllYears();
                  },
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: content.isSearchingForDateOfProduction.value
                        ? content.specificResForDateOfProduction.length * 43
                        : 0,
                    child: ListView.builder(
                        itemCount:
                            content.specificResForDateOfProduction.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              content.dateOfProductionController.value.text =
                                  content
                                      .specificResForDateOfProduction[index]!;
                              content.isSearchingForDateOfProduction.value =
                                  false;
                              content.dateOfProductionController.value
                                      .selection =
                                  TextSelection.collapsed(
                                      offset: content.dateOfProductionController
                                          .value.text.length);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: fixedPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(content
                                      .specificResForDateOfProduction[index]!
                                      .capitalize!),
                                  fixedSizedBoxHeight,
                                  index ==
                                          content.specificResForDateOfProduction
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
