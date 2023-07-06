import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/car.dart';
import '../internet/check_internet.dart';

Future getAllCarModels({String? vendorIdForUrl}) async {
  Car carVars = Get.put(Car());
  if (!await hasInternet()) {
    return;
  }
  if (!carVars.isSearchingForCarModel.value) {
    carVars.isSearchingForCarModel.value = true;
  }
  try {
    print("===============$vendorIdForUrl==============");
    Uri url = Uri.parse(
        "https://satc.live/api/General/Cars/Models/${vendorIdForUrl ?? ""}");
    List<Map> models = [];
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
    };
    http.Response response = await http.get(url, headers: headers);
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());

    for (int i = 0; i < dataRecieved["Data"].length; i++) {
      models.add(dataRecieved["Data"][i]);
    }
    print("This is models ${models.toString()}");
    carVars.specificResForCarModels.clear();
    for (Map element in models) {
      int recievedVendorId = element["id"];
      String vendorName = element["eng_name"];
      vendorName = vendorName.toLowerCase();
      if (vendorName.contains(
          carVars.carModelController["controller"]!.value.text.toLowerCase())) {
        carVars.specificResForCarModels
            .add({"id": recievedVendorId, "name": vendorName});
      }
    }
    if (carVars.specificResForCarModels.isEmpty) {
      carVars.isSearchingForCarModel.value = false;
    }
  } on Exception catch (e) {
    print(e.toString());
  }
}
