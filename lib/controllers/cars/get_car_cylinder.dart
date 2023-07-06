import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../models/car.dart';
import '../internet/check_internet.dart';

Future getAllCarCylinders({int? cylinderlId}) async {
  Car carVars = Get.put(Car());
  if (!await hasInternet()) {
    return;
  }
  if (!carVars.isSearchingForCarCylinder.value) {
    carVars.isSearchingForCarCylinder.value = true;
  }
  try {
    print("===============$cylinderlId==============");
    Uri url = Uri.parse(
        "https://satc.live/api/General/Cars/Models/Cylinder/${cylinderlId ?? ""}");
    List<Map> cylinder = [];
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
    };
    http.Response response = await http.get(url, headers: headers);
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());
    for (int i = 0; i < dataRecieved["Data"].length; i++) {
      cylinder.add(dataRecieved["Data"][i]);
    }
    carVars.specificResForCarCylinders.clear();
    for (Map element in cylinder) {
      int cylinderId = element["id"];
      String cylinderName = element["name"].toString();
      cylinderName = cylinderName.toLowerCase();
      if (cylinderName.contains(carVars
          .carCylinderController["controller"]!.value.text
          .toLowerCase())) {
        carVars.specificResForCarCylinders
            .add({"id": cylinderId, "name": cylinderName});
      }
    }
    if (carVars.specificResForCarCylinders.isEmpty) {
      carVars.isSearchingForCarCylinder.value = false;
    }
  } on Exception catch (e) {
    print(e.toString());
  }
}
