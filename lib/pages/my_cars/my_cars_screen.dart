import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/controllers/cars/get_cars.dart';
import 'package:sayaratech/controllers/cars/get_one_car.dart';
import 'package:sayaratech/controllers/cars/update_car.dart';
import 'package:sayaratech/pages/my_cars/add_cars_screen.dart';
import 'package:sayaratech/ui_manager/colors_manager.dart';
import 'package:sayaratech/ui_manager/fixed_numbers_manager.dart';
import 'package:sayaratech/ui_manager/sized_box_manager.dart';
import 'package:sayaratech/ui_manager/widgets/buttons/custom_button.dart';
import 'package:sayaratech/ui_manager/widgets/cards/car_card.dart';

import '../../models/car.dart';

class MyCarsScreen extends StatelessWidget {
  const MyCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Car carVars = Get.put(Car());
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.height * 0.2,
            width: Get.width,
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(fixedBorderRadius * 3),
                    bottomRight: Radius.circular(fixedBorderRadius * 3))),
            child: Stack(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      onPressed: () {
                        //reset all data
                        carVars.availableColorsController.value.text = "";
                        carVars.carVendorController["controller"]!.value.text =
                            "";
                        carVars.carFuelController.value.text = "";
                        carVars.serialNumberController.value.text = "";
                        carVars.carPlateNumberController.value.text = "";
                        carVars.carPlateCharactersController.value.text = "";
                        carVars.availableColorsController.value.text = "";
                        carVars.dateOfProductionController.value.text = "";
                        Get.to(() => const AddCarsScreen());
                      },
                      icon: Icon(
                        Icons.add_circle_outline_rounded,
                        size: 40,
                        color: whiteColor,
                      )),
                ),
                Center(
                  child: Text(
                    "My Cars",
                    style: TextStyle(
                        fontSize: 24,
                        color: whiteColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Car>>(
                future: myCarsList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: fixedMainPadding * 2),
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((_, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: fixedPadding),
                              child: CarCard(car: snapshot.data![index]),
                            );
                          })),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
          fixedSizedBoxHeight,
          Obx(
            () => carVars.isLoading.value
                ? const Center(
                    child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ))
                : Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: "Get Cars list",
                backgroundColor: Colors.deepOrange,
                onTap: () async {
                  await getCars();
                },
              ),
              fixedSizedBoxHeight,
              CustomButton(
                text: "Get One Car",
                backgroundColor: Colors.black,
                onTap: () async {
                  //shuld pass the real [id]
                  await getOneCar(id: "3");
                },
              ),
            ],
          ),
          fixedSizedBoxHeight,
          CustomButton(
            text: "Update Car",
            onTap: () async {
              //shuld pass the real [id]
              await updateOneCar(id: "3");
            },
          ),
          fixedSizedBoxHeight,
        ],
      ),
    );
  }
}

///This function to simulate the `getCustomerCars` function,
/// because of the problem that I mentioned in report
Future<List<Car>> myCarsList() async {
  return [
    Car(
        carId: "8434",
        carColor: "Yellow",
        carPlateNumber: "3923",
        carPlateCharacters: "S A Y",
        carVendorName: "Kia",
        carFuel: "Diesel",
        carSerialNumber: "3823040",
        carProductionDate: "2020"),
    Car(
        carId: "9302",
        carColor: "Green",
        carPlateNumber: "1249",
        carPlateCharacters: "T R E",
        carVendorName: "Hyundai",
        carFuel: "Petrol",
        carSerialNumber: "3920394",
        carProductionDate: "2022"),
  ];
}
