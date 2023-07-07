import 'package:flutter/material.dart';
import 'package:get/get.dart';

///All car variables
class Car extends GetxController {
  //Car vendor map that link vendor Id with name
  RxMap<String, Rx<dynamic>> carVendorController = <String, Rx<dynamic>>{
    "id": 0.obs,
    "controller": TextEditingController().obs
  }.obs;
  //Car model map that link model Id with name
  Map<String, Rx<dynamic>> carModelController = <String, Rx<dynamic>>{
    "id": 0.obs,
    "controller": TextEditingController().obs
  }.obs;
  //Car cylinder map that link cylinder Id with name
  Map<String, Rx<dynamic>> carCylinderController = <String, Rx<dynamic>>{
    "id": 0.obs,
    "controller": TextEditingController().obs
  }.obs;
  //Car fuel type map that link fuel type Id with name
  Map<String, Rx<dynamic>> carFuelController = <String, Rx<dynamic>>{
    "id": 0.obs,
    "controller": TextEditingController().obs
  }.obs;
  //Car color map that link color Id with name
  Map<String, Rx<dynamic>> carColorsController = <String, Rx<dynamic>>{
    "id": 0.obs,
    "controller": TextEditingController().obs
  }.obs;
  //License number text controller
  Rx<TextEditingController> licenseNumberController =
      TextEditingController().obs;
  //Car plate number text controller
  Rx<TextEditingController> carPlateNumberController =
      TextEditingController().obs;
  //Car plate characters text controller
  Rx<TextEditingController> carPlateCharactersController =
      TextEditingController().obs;
  //Car production date text controller
  Rx<TextEditingController> carProductionDateController =
      TextEditingController().obs;
  //bool value to check if customer is searching for car vendor or not
  Rx<bool> isSearchingForCarVendor = false.obs;
  //bool value to check if customer is searching for car model or not
  Rx<bool> isSearchingForCarModel = false.obs;
  //bool value to check if customer is searching for car cylinder or not
  Rx<bool> isSearchingForCarCylinder = false.obs;
  //bool value to check if customer is searching for car fuel or not
  Rx<bool> isSearchingForCarFuel = false.obs;
  //bool value to check if customer is searching for car color or not
  Rx<bool> isSearchingForCarColors = false.obs;
  //bool value to check if customer is searching for car production date or not
  Rx<bool> isSearchingForDateOfProduction = false.obs;
  //bool value to check if [getCars] function runned or not
  Rx<bool> isRunGetCarsFunction = false.obs;
  //Gowable list for car vendors, updated when [getCarsVendors] function run
  RxList<Map<String, dynamic>> specificResForCarVendors =
      <Map<String, dynamic>>[].obs;
  //Gowable list for car models, updated when [getCarModels] function run
  RxList<Map<String, dynamic>> specificResForCarModels =
      <Map<String, dynamic>>[].obs;
  //Gowable list for car cylinders, updated when [getCarCylinders] function run
  RxList<Map<String, dynamic>> specificResForCarCylinders =
      <Map<String, dynamic>>[].obs;
  //Gowable list for car fuel types, updated when [getCarFuelTypes] function run
  RxList<Map<String, dynamic>> specificResForCarFuel =
      <Map<String, dynamic>>[].obs;
  //Gowable list for car colors, updated when [getCarColors] function run
  RxList<Map<String, dynamic>> specificResForCarColors =
      <Map<String, dynamic>>[].obs;
  //Gowable list for car production date, updated when [getCarProductionDates] function run
  RxList<String?> specificResForDateOfProduction = <String?>[].obs;
  //Gowable list for cars, updated when [getCars] function run
  RxList<Car> carsList = <Car>[].obs;
  //When loading set it to true
  Rx<bool> isLoading = false.obs;
  //Scroll controller
  Rx<ScrollController> scrollController = ScrollController().obs;

  //Unchangable car varibles
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
}
