import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/car.dart';
import '../../../ui_manager/extensions_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/text_field_container.dart';

import '../../../controllers/cars/get_car_fuel_type.dart';
import '../../../../ui_manager/fixed_numbers_manager.dart';

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
                  controller: content.carFuelController["controller"]!.value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Fuel Type: Diesel, Gasoline, ..",
                      suffixIcon: InkWell(
                        onTap: () {
                          content.isSearchingForCarFuel.value =
                              !content.isSearchingForCarFuel.value;
                          if (content.isSearchingForCarFuel.value) {
                            getAllCarFuels();
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
                    getAllCarFuels();
                  },
                  onChanged: (v) async {
                    if (!content.isSearchingForCarFuel.value) {
                      content.isSearchingForCarFuel.value = true;
                    }
                    getAllCarFuels();
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
                              print(content.specificResForCarFuel.toString());
                              content.carFuelController["controller"]!.value
                                  .text = content.specificResForCarFuel[index]
                                      ["name"]
                                  .toString()
                                  .firstLetterCapitalize();
                              content.carFuelController["id"]!.value =
                                  content.specificResForCarFuel[index]["id"];
                              content.isSearchingForCarFuel.value = false;
                              content.carFuelController["controller"]!.value
                                      .selection =
                                  TextSelection.collapsed(
                                      offset: content
                                          .carFuelController["controller"]!
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
                                  Text(content.specificResForCarFuel[index]
                                          ["name"]
                                      .toString()
                                      .firstLetterCapitalize()),
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
