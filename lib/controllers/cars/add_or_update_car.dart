import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:sayaratech/controllers/cars/get_cars.dart';
import '../../../models/car.dart';
import '../../controllers/tokens/refresh_token.dart';
import '../../../models/which_home.dart';
import '../../pages/home/home.dart';
import '../../../models/authentication.dart';
import '../internet/check_internet.dart';

/// Add customer or update a car, If token expired refresh it without asking customer credentials
Future addOrUpdateCar({int? idForUpdate}) async {
  Car addCarVars = Get.put(Car());
  Authentication authVars = Get.put(Authentication());
  if (!await hasInternet()) {
    return;
  }
  addCarVars.isLoading.value = true;
  try {
    Uri url = Uri.parse(idForUpdate != null
        ? "https://satc.live/api/Customer/UpdaetCar?id=$idForUpdate"
        : "https://satc.live/api/Customer/AddCar");
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
      'Authorization': 'Bearer ${authVars.bearerToken.value}'
    };
    print(addCarVars.carVendorController["id"]);
    print(addCarVars.carModelController["id"]);
    print(addCarVars.carColorsController["id"]);
    print(addCarVars.carCylinderController["id"]);
    print(addCarVars.carFuelController["id"]);
    Map body = <String, dynamic>{
      "Car_Vendor_id": addCarVars.carVendorController["id"]!.value.toString(),
      "Car_Model_id": addCarVars.carModelController["id"]!.value.toString(),
      "Car_Color_id": addCarVars.carColorsController["id"]!.value.toString(),
      "Car_Models_Engine_id":
          addCarVars.carCylinderController["id"]!.value.toString(),
      "Car_Fule_Type_id": addCarVars.carFuelController["id"]!.value.toString(),
      "Model_Year": addCarVars.dateOfProductionController.value.text,
      "Board_No":
          "${addCarVars.carPlateNumberController.value.text} ${addCarVars.carPlateCharactersController.value.text}",
      "Car_Lic_No": addCarVars.licenseNumberController.value.text,
      "Last_KMs_Usages": "0",
    };
    http.Response response = await http.post(url, headers: headers, body: body);
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());
    if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
      //If success then go to my cars screen
      getCars();
      var whichHome = Get.put(WhichHome());
      whichHome.whichPage.value = "Cars";
      Get.to(() => const Home());
    } else {
      addCarVars.isLoading.value = false;
    }
  } on Exception catch (e) {
    log(e.toString());
    //This if statement to analyze error
    //If error happen because of expired token; refresh the token
    if (e.toString().contains(
        "FormatException: Unexpected end of input (at character 1)")) {
      if (await refreshToken()) {
        idForUpdate != null
            ? addOrUpdateCar(idForUpdate: idForUpdate)
            : addOrUpdateCar();
      }
    }
    addCarVars.isLoading.value = false;
  }
  addCarVars.isLoading.value = false;
}
