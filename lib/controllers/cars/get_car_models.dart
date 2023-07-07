import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../models/car.dart';
import '../internet/check_internet.dart';

/// Get all car models for specific car vendor
Future getCarModels({int? vendorIdForUrl}) async {
  //get all car variables
  Car carVars = Get.put(Car());
  //Check internet access before begining
  if (!await hasInternet()) {
    return;
  }
  if (!carVars.isSearchingForCarModel.value) {
    carVars.isSearchingForCarModel.value = true;
  }
  try {
    //Request's URL, pass vendor Id in url
    Uri url = Uri.parse(
        "https://satc.live/api/General/Cars/Models/${vendorIdForUrl ?? ""}");

    //Header for post request, check customer language before setting 'lng'
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
    };
    //'Get' request
    http.Response response = await http.get(url, headers: headers);
    //Decode json data
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());
    //Check if the 'status' of the request is true or not
    if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
      //Start local models list
      List<Map> models = [];
      //loop to add models in the local list
      for (int i = 0; i < dataRecieved["Data"].length; i++) {
        models.add(dataRecieved["Data"][i]);
      }
      //Clear global car models list before refreshing it
      carVars.specificResForCarModels.clear();
      //Start loop to add models in the global list
      for (Map model in models) {
        //store model name
        String modelName =
            model[Get.locale!.languageCode == 'en' ? "eng_name" : "name"];
        modelName = modelName.toLowerCase();
        //If model name contains the entered string add it to the list
        if (modelName.contains(carVars
            .carModelController["controller"]!.value.text
            .toLowerCase())) {
          carVars.specificResForCarModels
              .add({"id": model["id"], "name": modelName});
        }
      }
    }
    if (carVars.specificResForCarModels.isEmpty) {
      carVars.isSearchingForCarModel.value = false;
    }
  } on Exception catch (e) {
    log(e.toString());
  }
}
