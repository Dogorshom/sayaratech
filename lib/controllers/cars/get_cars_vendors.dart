import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/car.dart';
import '../internet/check_internet.dart';

Future getAllCarVendors() async {
  Car carVars = Get.put(Car());
  if (!await hasInternet()) {
    return;
  }
  if (!carVars.isSearchingForCarVendor.value) {
    carVars.isSearchingForCarVendor.value = true;
  }
  try {
    Uri url = Uri.parse("https://satc.live/api/General/Cars/Vendors");
    List<Map> vendors = [];
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
    };
    http.Response response = await http.get(url, headers: headers);
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());

    if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
      for (int i = 0; i < dataRecieved["Data"].length; i++) {
        vendors.add(dataRecieved["Data"][i]);
      }
      print("This is vendors ${vendors.toString()}");
      carVars.specificResForCarVendors.clear();
      for (Map element in vendors) {
        int vendorId = element["id"];
        String vendorName =
            element[Get.locale!.languageCode == 'en' ? "eng_name" : "name"];
        vendorName = vendorName.toLowerCase();
        if (vendorName.contains(carVars
            .carVendorController["controller"]!.value.text
            .toLowerCase())) {
          carVars.specificResForCarVendors
              .add({"id": vendorId, "name": vendorName});
        }
      }
    }
    if (carVars.specificResForCarVendors.isEmpty) {
      carVars.isSearchingForCarVendor.value = false;
    }
  } on Exception catch (e) {
    print(e.toString());
  }
}
