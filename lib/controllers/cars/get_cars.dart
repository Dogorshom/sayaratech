import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/authentication.dart';
import '../../models/car.dart';
import '../internet/check_internet.dart';
import '../tokens/refresh_token.dart';

Future getCars() async {
  Car carVars = Get.put(Car());
  Authentication authVars = Get.put(Authentication());

  if (!await hasInternet()) {
    return;
  }
  carVars.isLoading.value = true;

  try {
    Uri url = Uri.parse("https://satc.live/api/Customer/Cars");
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
      'Authorization': 'Bearer ${authVars.bearerToken.value}'
    };
    http.Response response = await http.post(url, headers: headers);
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());
    if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
      List<Car> mycars = [];
      for (Map element in dataRecieved["Data"]) {
        mycars.add(
          Car(
            carId: element["id"],
            carVendorId: element["Car_Vendor_id"],
            carModelId: element["Car_Model_id"],
            carColorId: element["Car_Color_id"],
            carLicenseNumber: element["Car_Lic_No"].toString(),
            carPlateNumber: element["Board_No"].toString().split(" ").first,
            carPlateCharacters: element["Board_No"].toString().split(" ").last,
            cylinderId: element["Cylinder_id"],
            // cylinder name not provided by API
            // cylinder: element["Cylinder"],
            carFuelId: element["Car_Fule_Type_id"],
            carProductionDate: element["Model_Year"].toString(),
            carVendorName: element[Get.locale!.languageCode == 'en'
                ? "Vendor_egn_name"
                : "Vendor_name"],
            carModel: element[Get.locale!.languageCode == 'en'
                ? "Models_eng_name"
                : "Models_name"],
            carColor: element[Get.locale!.languageCode == 'en'
                ? "color_eng_name"
                : "color_name"],
            carFuel: element[Get.locale!.languageCode == 'en'
                ? "Fule_Type_eng_name"
                : "Fule_Type_name"],
          ),
        );
      }
      carVars.isLoading.value = false;
      carVars.carsList.value = mycars;
      carVars.isRunGetCarsFunction.value = true;
      // return mycars;
    } else {
      carVars.isLoading.value = false;
    }
    //This is just for showing that don't have cars added
  } on Exception catch (e) {
    print(e.toString());
    //This if statement to analyze error
    //If error happen because of expired token; refresh the token
    if (e.toString().contains(
        "FormatException: Unexpected end of input (at character 1)")) {
      if (await refreshToken()) {
        getCars();
      }
    }
    carVars.isLoading.value = false;
  }
  carVars.isLoading.value = false;
}
