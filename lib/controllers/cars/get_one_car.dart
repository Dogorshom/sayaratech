import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../models/authentication.dart';
import '../../../models/car.dart';
import '../internet/check_internet.dart';
import '../tokens/refresh_token.dart';

///Get customer car data
Future getOneCarDetails({required int carId}) async {
  //get all car variables
  Car carVars = Get.put(Car());
  //get all authentication variables
  Authentication authVars = Get.put(Authentication());
  //Check internet access before begining
  if (!await hasInternet()) {
    return;
  }
  //Start loading
  carVars.isLoading.value = true;
  try {
    //Request's URL, pass car Id to the url
    Uri url = Uri.parse("https://satc.live/api/Customer/Car/$carId");
    //Header for post request, check customer language before setting 'lng'
    //Pass token as header parameter
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
      'Authorization': 'Bearer ${authVars.bearerToken.value}'
    };
    //'Post' request
    http.Response response = await http.post(url, headers: headers);
    //Decode json data
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());
    //Check if the 'status' of the request is true or not
    if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
      //Start local car variable
      Car mycar = Car(
        carId: dataRecieved["Data"]["id"],
        carVendorId: dataRecieved["Data"]["Car_Vendor_id"],
        carModelId: dataRecieved["Data"]["Car_Model_id"],
        carColorId: dataRecieved["Data"]["Car_Color_id"],
        carLicenseNumber: dataRecieved["Data"]["Car_Lic_No"].toString(),
        carPlateNumber:
            dataRecieved["Data"]["Board_No"].toString().split(" ").first,
        carPlateCharacters:
            dataRecieved["Data"]["Board_No"].toString().split(" ").last,
        cylinderId: dataRecieved["Data"]["Cylinder_id"],
        // cylinder name not provided by API
        // cylinder: dataRecieved["Data"]["Cylinder"],
        carFuelId: dataRecieved["Data"]["Car_Fule_Type_id"],
        carProductionDate: dataRecieved["Data"]["Model_Year"].toString(),
        carVendorName: dataRecieved["Data"][Get.locale!.languageCode == 'en'
            ? "Vendor_egn_name"
            : "Vendor_name"],
        carModel: dataRecieved["Data"][Get.locale!.languageCode == 'en'
            ? "Models_eng_name"
            : "Models_name"],
        carColor: dataRecieved["Data"][
            Get.locale!.languageCode == 'en' ? "color_eng_name" : "color_name"],
        carFuel: dataRecieved["Data"][Get.locale!.languageCode == 'en'
            ? "Fule_Type_eng_name"
            : "Fule_Type_name"],
      );
      //Stop loading
      carVars.isLoading.value = false;
      //Show car details in a dialog
      Get.defaultDialog(
          backgroundColor: Get.theme.cardColor,
          title: "Car Full Details",
          content: carDetailsColumn(mycar));
    } else {
      //Stop loading
      carVars.isLoading.value = false;
      return;
    }
    //This is just for showing that don't have cars added
  } on Exception catch (e) {
    //log the error
    log(e.toString());
    //This if statement to analyze error
    //If error happen because of expired token; refresh the token
    if (e.toString().contains(
        "FormatException: Unexpected end of input (at character 1)")) {
      if (await refreshToken()) {
        getOneCarDetails(carId: carId);
      }
    }
    //Stop loading
    carVars.isLoading.value = false;
    return;
  }
  //Stop loading
  carVars.isLoading.value = false;
  return;
}

///Car Details Widget to show one car details
///
///Need a Car to preview
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
