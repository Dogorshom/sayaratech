import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../models/car.dart';
import '../internet/check_internet.dart';

/// Get all car cylinders for specific car model
Future getAllCarCylinders({required int? cylinderlId}) async {
  //get all car variables
  Car carVars = Get.put(Car());
  //Check internet access before begining
  if (!await hasInternet()) {
    return;
  }
  if (!carVars.isSearchingForCarCylinder.value) {
    carVars.isSearchingForCarCylinder.value = true;
  }
  try {
    //Request's URL, pass cylinder Id in url
    Uri url = Uri.parse(
        "https://satc.live/api/General/Cars/Models/Cylinder/$cylinderlId");
    //Header for post request, check customer language before setting 'lng'
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
    };
    //'Get' request
    http.Response response = await http.get(url, headers: headers);
    //Decode json data
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());
    //loop to add cylinders in the local list
    //Check if the 'status' of the request is true or not
    if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
      //Start local cylinder list
      List<Map> cylinders = [];
      for (int i = 0; i < dataRecieved["Data"].length; i++) {
        cylinders.add(dataRecieved["Data"][i]);
      }
      //Clear global cylinders list before refreshing it
      carVars.specificResForCarCylinders.clear();
      //Start loop to add cylinder in the global list
      for (Map cylinder in cylinders) {
        //store cylinder name
        String cylinderName = cylinder["name"].toString();
        cylinderName = cylinderName.toLowerCase();
        //If cylinder name contains the entered string add it to the list
        if (cylinderName.contains(carVars
            .carCylinderController["controller"]!.value.text
            .toLowerCase())) {
          carVars.specificResForCarCylinders
              .add({"id": cylinder["id"], "name": cylinderName});
        }
      }
    }
    if (carVars.specificResForCarCylinders.isEmpty) {
      carVars.isSearchingForCarCylinder.value = false;
    }
  } on Exception catch (e) {
    log(e.toString());
  }
}
