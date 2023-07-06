import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/authentication.dart';
import '../../models/car.dart';
import '../../ui_manager/sized_box_manager.dart';
import '../internet/check_internet.dart';
import '../tokens/refresh_token.dart';

Future updateOneCar({required String id}) async {
  //just for showning loading
  Car carVars = Get.put(Car());
  Authentication authVars = Get.put(Authentication());

  if (!await hasInternet()) {
    return;
  }
  carVars.isLoading.value = true;

  try {
    Uri url = Uri.parse("https://satc.live/api/Customer/UpdaetCar/$id");

    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
      'Authorization': 'Bearer ${authVars.bearerToken.value}'
    };
    Map body = <String, dynamic>{
      "Car_Vendor_id": "0",
      "Car_Model_id": "0",
      "Car_Color_id": "0",
      "Model_Year": "0",
      "Board_No": "string",
      "Car_Lic_No": "string",
      "Last_KMs_Usages": "0",
      "Car_Models_Engine_id": "0",
      "Car_Fule_Type_id": "0"
    };
    http.Response response = await http.post(url, headers: headers, body: body);
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());
  } on Exception catch (e) {
    print(e.toString());
    //This if statement to analyze error
    //If error happen because of expired token; refresh the token
    if (e.toString().contains(
        "FormatException: Unexpected end of input (at character 1)")) {
      if (await refreshToken()) {
        updateOneCar(id: id);
      }
    }
    //This is just for showing that we don't have car with this id
    Get.defaultDialog(
        title: "Operation response",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("The error: $e"),
          ],
        ));
    carVars.isLoading.value = false;
  }
  carVars.isLoading.value = false;
}
