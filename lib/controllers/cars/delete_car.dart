import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../ui_manager/colors_manager.dart';
import '../../../models/authentication.dart';
import '../../../models/car.dart';
import '../internet/check_internet.dart';
import '../tokens/refresh_token.dart';

Future deleteCar({required int carId, required int indexInList}) async {
  Car carVars = Get.put(Car());
  Authentication authVars = Get.put(Authentication());

  if (!await hasInternet()) {
    return;
  }
  carVars.isLoading.value = true;

  try {
    Uri url = Uri.parse("https://satc.live/api/Customer/DeleteCar?id=$carId");
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
      'Authorization': 'Bearer ${authVars.bearerToken.value}'
    };
    http.Response response = await http.post(url, headers: headers);
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());
    if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
      carVars.carsList.removeAt(indexInList);
      Get.snackbar(
          "Successful Operation", "You have successfully delete your car",
          backgroundColor: greenColor.withOpacity(0.7));
      carVars.isLoading.value = false;
    } else {
      Get.snackbar("Failed Operation", "There is something go wrong",
          backgroundColor: redColor.withOpacity(0.7));
      carVars.isLoading.value = false;
    }
    //This is just for showing that don't have cars added
  } on Exception catch (e) {
    print(e.toString());
    //This if statement to analyze error
    //If error happen because of expired token; refresh the token
    if (e.toString().contains(
        "FormatException: Unexpected end of input (at character 1)")) {
      if (await refreshToken()) {
        deleteCar(carId: carId, indexInList: indexInList);
      }
    }
    carVars.isLoading.value = false;
  }
  carVars.isLoading.value = false;
  return;
}

Widget carDetailsColumn(Car mycar) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            "Id: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carId}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Vendor Id: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carVendorId}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Vendor Name: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carVendorName}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Model Id: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carModelId}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Mode Name: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carModel}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Color id: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carColorId}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Color Name: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carColor}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Model Year: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carProductionDate}"),
        ],
      ),
      Row(
        children: [
          Text(
            "License: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carLicenseNumber}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Plate: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carPlateNumber} ${mycar.carPlateCharacters}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Fuel Type: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carFuel}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Cylinder Id: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.cylinderId}"),
        ],
      ),
    ],
  );
}
