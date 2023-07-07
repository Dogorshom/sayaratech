import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../models/car.dart';
import '../internet/check_internet.dart';

/// Get all car vendors
Future getAllCarVendors() async {
  //get all car variables
  Car carVars = Get.put(Car());
  //Check internet access before begining
  if (!await hasInternet()) {
    return;
  }
  if (!carVars.isSearchingForCarVendor.value) {
    carVars.isSearchingForCarVendor.value = true;
  }
  try {
    //Request's URL
    Uri url = Uri.parse("https://satc.live/api/General/Cars/Vendors");

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
      //Start local vendors list
      List<Map> vendors = [];
      //loop to add vendors in the local list
      for (int i = 0; i < dataRecieved["Data"].length; i++) {
        vendors.add(dataRecieved["Data"][i]);
      }
      //Clear global vendors list before refreshing it
      carVars.specificResForCarVendors.clear();
      //Start loop to add vendor in the global list
      for (Map vendor in vendors) {
        //store vendor name
        String vendorName =
            vendor[Get.locale!.languageCode == 'en' ? "eng_name" : "name"];
        vendorName = vendorName.toLowerCase();
        //If vendor name contains the entered string add it to the list
        if (vendorName.contains(carVars
            .carVendorController["controller"]!.value.text
            .toLowerCase())) {
          carVars.specificResForCarVendors
              .add({"id": vendor["id"], "name": vendorName});
        }
      }
    }
    if (carVars.specificResForCarVendors.isEmpty) {
      carVars.isSearchingForCarVendor.value = false;
    }
  } on Exception catch (e) {
    log(e.toString());
  }
}
