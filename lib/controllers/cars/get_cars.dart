import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../models/authentication.dart';
import '../../../models/car.dart';
import '../internet/check_internet.dart';
import '../tokens/refresh_token.dart';

///Get customer Cars data
Future getCars() async {
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
    //Request's URL
    Uri url = Uri.parse("https://satc.live/api/Customer/Cars");
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
      //Start local cars list
      List<Car> mycars = [];
      //Start loop to add cars to local list
      for (Map car in dataRecieved["Data"]) {
        mycars.add(
          Car(
            carId: car["id"],
            carVendorId: car["Car_Vendor_id"],
            carModelId: car["Car_Model_id"],
            carColorId: car["Car_Color_id"],
            carLicenseNumber: car["Car_Lic_No"].toString(),
            carPlateNumber: car["Board_No"].toString().split(" ").first,
            carPlateCharacters: car["Board_No"].toString().split(" ").last,
            cylinderId: car["Cylinder_id"],
            // cylinder name not provided by API
            // cylinder: car["Cylinder"],
            carFuelId: car["Car_Fule_Type_id"],
            carProductionDate: car["Model_Year"].toString(),
            carVendorName: car[Get.locale!.languageCode == 'en'
                ? "Vendor_egn_name"
                : "Vendor_name"],
            carModel: car[Get.locale!.languageCode == 'en'
                ? "Models_eng_name"
                : "Models_name"],
            carColor: car[Get.locale!.languageCode == 'en'
                ? "color_eng_name"
                : "color_name"],
            carFuel: car[Get.locale!.languageCode == 'en'
                ? "Fule_Type_eng_name"
                : "Fule_Type_name"],
          ),
        );
      }
      //Stop loading
      carVars.isLoading.value = false;
      //Move local list to the global cars list
      carVars.carsList.value = mycars;
      //Prove that this function has been run, so no need to call it again every time
      carVars.isRunGetCarsFunction.value = true;
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
        getCars();
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
