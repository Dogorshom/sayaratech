import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Car extends GetxController {
  RxMap<String, Rx<dynamic>> carVendorController = <String, Rx<dynamic>>{
    "id": "".obs,
    "controller": TextEditingController().obs
  }.obs;
  Map<String, Rx<dynamic>> carModelController = <String, Rx<dynamic>>{
    "id": "".obs,
    "controller": TextEditingController().obs
  }.obs;
  Map<String, Rx<dynamic>> carCylinderController = <String, Rx<dynamic>>{
    "id": "".obs,
    "controller": TextEditingController().obs
  }.obs;
  Rx<TextEditingController> carFuelController = TextEditingController().obs;
  Rx<TextEditingController> serialNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> carPlateNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> carPlateCharactersController =
      TextEditingController().obs;
  Rx<TextEditingController> availableColorsController =
      TextEditingController().obs;
  Rx<TextEditingController> dateOfProductionController =
      TextEditingController().obs;
  Rx<bool> isSearchingForCarVendor = false.obs;
  Rx<bool> isSearchingForCarModel = false.obs;
  Rx<bool> isSearchingForCarCylinder = false.obs;
  Rx<bool> isSearchingForCarFuel = false.obs;
  Rx<bool> isSearchingForAvailableColors = false.obs;
  Rx<bool> isSearchingForDateOfProduction = false.obs;
  RxList<Map<String, dynamic>> specificResForCarVendors =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specificResForCarModels =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specificResForCarCylinders =
      <Map<String, dynamic>>[].obs;
  RxList<String?> specificResForCarFuel = <String?>[].obs;
  Rx<bool> isLoading = false.obs;
  RxList<String?> specificResForAvailableColors = <String?>[].obs;
  RxList<String?> specificResForDateOfProduction = <String?>[].obs;
  final String? carId;
  final String? carVendorName;
  final String? carVendorId;
  final String? carModel;
  final String? carModelId;
  final String? carSerialNumber;
  final String? carFuel;
  final String? carPlateNumber;
  final String? carPlateCharacters;
  final String? carColor;
  final String? carProductionDate;
  final String? cylinder;

  Car({
    this.carId,
    this.carVendorId,
    this.carVendorName,
    this.carModel,
    this.carModelId,
    this.carSerialNumber,
    this.carFuel,
    this.carPlateNumber,
    this.carPlateCharacters,
    this.carColor,
    this.carProductionDate,
    this.cylinder,
  });

  // getAllCarVendors() async {
  //   List<Map> vendorsNames = await getCarsVendors();
  //   var carVars = Get.put(Car());
  //   carVars.specificResForCarVendors.clear();
  //   for (Map element in vendorsNames) {
  //     element["eng_name"] = element["eng_name"].toLowerCase();
  //     if (element["eng_name"]
  //         .contains(carVars.carVendorController.value.text.toLowerCase())) {
  //       carVars.specificResForCarVendors.add(element["eng_name"].toLowerCase());
  //     }
  //   }
  //   if (carVars.specificResForCarVendors.isEmpty) {
  //     carVars.isSearchingForCarVendor.value = false;
  //   }
  // }

  getAllCarFuels() async {
    List<String> allFuelTypes = ["Petrol", "Diesel", "Electric", "Hybird"];
    specificResForCarFuel.clear();
    for (String element in allFuelTypes) {
      element = element.toLowerCase();
      if (element.contains(carFuelController.value.text.toLowerCase())) {
        specificResForCarFuel.add(element.toLowerCase());
      }
    }
    if (specificResForCarFuel.isEmpty) {
      isSearchingForCarVendor.value = false;
    }
  }

  getAllColorsAvailable() async {
    List<String> allColors = [
      "Yellow",
      "Red",
      "Green",
      "Grey",
      "White",
      "Black"
    ];
    specificResForAvailableColors.clear();
    for (String element in allColors) {
      element = element.toLowerCase();
      if (element
          .contains(availableColorsController.value.text.toLowerCase())) {
        specificResForAvailableColors.add(element.toLowerCase());
      }
    }
    if (specificResForAvailableColors.isEmpty) {
      isSearchingForAvailableColors.value = false;
    }
  }

  getAllYears() async {
    List<String> allyears = [
      "2010",
      "2011",
      "2012",
      "2013",
      "2014",
      "2015",
      "2016",
      "2017",
      "2018",
      "2019",
      "2020",
      "2021",
      "2022",
      "2023",
    ];
    specificResForDateOfProduction.clear();
    for (String element in allyears) {
      element = element.toLowerCase();
      if (element
          .contains(dateOfProductionController.value.text.toLowerCase())) {
        specificResForDateOfProduction.add(element.toLowerCase());
      }
    }
    if (specificResForDateOfProduction.isEmpty) {
      isSearchingForDateOfProduction.value = false;
    }
  }
}
