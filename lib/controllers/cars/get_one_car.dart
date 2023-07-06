import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sayaratech/ui_manager/sized_box_manager.dart';
import '../../models/authentication.dart';
import '../../models/car.dart';
import '../internet/check_internet.dart';
import '../tokens/refresh_token.dart';

Future getOneCar({required String id}) async {
  //just for showning loading
  Car carVars = Get.put(Car());
  Authentication authVars = Get.put(Authentication());

  if (!await hasInternet()) {
    return;
  }
  carVars.isLoading.value = true;

  try {
    Uri url = Uri.parse("https://satc.live/api/Customer/Car/$id");

    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
      'Authorization': 'Bearer ${authVars.bearerToken.value}'
    };
    http.Response response = await http.post(url, headers: headers);
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());
    //This is just for showing that we can't access that car
    Get.defaultDialog(
        title: "Operation response",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status: ${dataRecieved["status"]}"),
            fixedSmallSizedBoxHeight,
            Text("Message: ${dataRecieved["message"]}"),
            fixedSmallSizedBoxHeight,
            Text("Error: ${dataRecieved["error"]}"),
            fixedSmallSizedBoxHeight,
            Text("Data: ${dataRecieved["Data"]}"),
          ],
        ));
  } on Exception catch (e) {
    print(e.toString());
    //This if statement to analyze error
    //If error happen because of expired token; refresh the token
    if (e.toString().contains(
        "FormatException: Unexpected end of input (at character 1)")) {
      if (await refreshToken()) {
        getOneCar(id: id);
      }
    }
    carVars.isLoading.value = false;
  }
  carVars.isLoading.value = false;
}
