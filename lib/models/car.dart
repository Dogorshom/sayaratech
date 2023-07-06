import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Car extends GetxController {
  RxMap<String, Rx<dynamic>> carVendorController = <String, Rx<dynamic>>{
    "id": 0.obs,
    "controller": TextEditingController().obs
  }.obs;
  Map<String, Rx<dynamic>> carModelController = <String, Rx<dynamic>>{
    "id": 0.obs,
    "controller": TextEditingController().obs
  }.obs;
  Map<String, Rx<dynamic>> carCylinderController = <String, Rx<dynamic>>{
    "id": 0.obs,
    "controller": TextEditingController().obs
  }.obs;
  Map<String, Rx<dynamic>> carFuelController = <String, Rx<dynamic>>{
    "id": 0.obs,
    "controller": TextEditingController().obs
  }.obs;
  Map<String, Rx<dynamic>> carColorsController = <String, Rx<dynamic>>{
    "id": 0.obs,
    "controller": TextEditingController().obs
  }.obs;
  // Rx<TextEditingController> carFuelController = TextEditingController().obs;
  Rx<TextEditingController> licenseNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> carPlateNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> carPlateCharactersController =
      TextEditingController().obs;
  // Rx<TextEditingController> availableColorsController =
  //     TextEditingController().obs;
  Rx<TextEditingController> dateOfProductionController =
      TextEditingController().obs;
  Rx<bool> isSearchingForCarVendor = false.obs;
  Rx<bool> isSearchingForCarModel = false.obs;
  Rx<bool> isSearchingForCarCylinder = false.obs;
  Rx<bool> isSearchingForCarFuel = false.obs;
  Rx<bool> isSearchingForCarColors = false.obs;
  Rx<bool> isSearchingForDateOfProduction = false.obs;
  Rx<bool> isRunGetCarsFunction = false.obs;
  RxList<Map<String, dynamic>> specificResForCarVendors =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specificResForCarModels =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specificResForCarCylinders =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specificResForCarFuel =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specificResForCarColors =
      <Map<String, dynamic>>[].obs;
  RxList<String?> specificResForDateOfProduction = <String?>[].obs;
  Rx<bool> isLoading = false.obs;
  RxList<Car> carsList = <Car>[].obs;
  final int? carId;
  final String? carVendorName;
  final int? carVendorId;
  final String? carModel;
  final int? carModelId;
  final String? carFuel;
  final int? carFuelId;
  final String? carColor;
  final int? carColorId;
  final String? cylinder;
  final int? cylinderId;
  final String? carLicenseNumber;
  final String? carPlateNumber;
  final String? carPlateCharacters;
  final String? carProductionDate;

  Car(
      {this.carId,
      this.carVendorName,
      this.carVendorId,
      this.carModel,
      this.carModelId,
      this.carFuel,
      this.carFuelId,
      this.carColor,
      this.carColorId,
      this.cylinder,
      this.cylinderId,
      this.carLicenseNumber,
      this.carPlateNumber,
      this.carPlateCharacters,
      this.carProductionDate});

  // getAllCarFuels() async {
  //   List<String> allFuelTypes = ["Petrol", "Diesel", "Electric", "Hybird"];
  //   specificResForCarFuel.clear();
  //   for (String element in allFuelTypes) {
  //     element = element.toLowerCase();
  //     if (element.contains(carFuelController.value.text.toLowerCase())) {
  //       specificResForCarFuel.add(element.toLowerCase());
  //     }
  //   }
  //   if (specificResForCarFuel.isEmpty) {
  //     isSearchingForCarVendor.value = false;
  //   }
  // }
}
