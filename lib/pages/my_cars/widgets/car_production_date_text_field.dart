import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/car.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/text_field_container.dart';

import '../../../controllers/cars/get_car_production_date.dart';
import '../../../../ui_manager/fixed_numbers_manager.dart';

///Car prdouction dates text field that shows up on adding or updating a car
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
                  controller: content.carProductionDateController.value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Production Date".tr,
                      suffixIcon: InkWell(
                        onTap: () {
                          content.scrollController.value.animateTo(
                              Get.height * 0.2,
                              curve: Curves.easeOut,
                              duration: const Duration(seconds: 1));
                          content.isSearchingForDateOfProduction.value =
                              !content.isSearchingForDateOfProduction.value;
                          if (content.isSearchingForDateOfProduction.value) {
                            getCarProductionDates();
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
                    content.scrollController.value.animateTo(Get.height * 0.2,
                        curve: Curves.easeOut,
                        duration: const Duration(seconds: 1));
                    if (!content.isSearchingForDateOfProduction.value) {
                      content.isSearchingForDateOfProduction.value = true;
                    }
                    getCarProductionDates();
                  },
                  onChanged: (v) async {
                    if (!content.isSearchingForDateOfProduction.value) {
                      content.isSearchingForDateOfProduction.value = true;
                    }
                    getCarProductionDates();
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
                              FocusScope.of(context).unfocus();
                              content.carProductionDateController.value.text =
                                  content
                                      .specificResForDateOfProduction[index]!;
                              content.isSearchingForDateOfProduction.value =
                                  false;
                              content.carProductionDateController.value
                                      .selection =
                                  TextSelection.collapsed(
                                      offset: content
                                          .carProductionDateController
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
