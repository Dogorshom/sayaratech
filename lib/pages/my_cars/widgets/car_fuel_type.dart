import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/models/car.dart';
import 'package:sayaratech/ui_manager/sized_box_manager.dart';
import 'package:sayaratech/ui_manager/widgets/text_field_container.dart';

import '../../../ui_manager/fixed_numbers_manager.dart';

class CarFuelTypeTextField extends StatelessWidget {
  const CarFuelTypeTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: GetX<Car>(
          init: Car(),
          builder: (content) {
            return Column(
              children: [
                TextField(
                  controller: content.carFuelController.value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Fuel Type: Diesel, Gasoline, ..",
                      suffixIcon: InkWell(
                        onTap: () {
                          content.isSearchingForCarFuel.value =
                              !content.isSearchingForCarFuel.value;
                          if (content.isSearchingForCarFuel.value) {
                            content.getAllCarFuels();
                          }
                        },
                        child: Icon(
                          content.isSearchingForCarFuel.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 24,
                        ),
                      )),
                  style: Get.textTheme.bodyMedium,
                  onTap: () {
                    if (!content.isSearchingForCarFuel.value) {
                      content.isSearchingForCarFuel.value = true;
                    }
                    content.getAllCarFuels();
                  },
                  onChanged: (v) async {
                    if (!content.isSearchingForCarFuel.value) {
                      content.isSearchingForCarFuel.value = true;
                    }
                    content.getAllCarFuels();
                  },
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: content.isSearchingForCarFuel.value
                        ? content.specificResForCarFuel.length * 43
                        : 0,
                    child: ListView.builder(
                        itemCount: content.specificResForCarFuel.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              content.carFuelController.value.text =
                                  content.specificResForCarFuel[index]!;
                              content.isSearchingForCarFuel.value = false;
                              content.carFuelController.value.selection =
                                  TextSelection.collapsed(
                                      offset: content
                                          .carFuelController.value.text.length);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: fixedPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(content.specificResForCarFuel[index]!
                                      .capitalize!),
                                  fixedSizedBoxHeight,
                                  index ==
                                          content.specificResForCarFuel.length -
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
