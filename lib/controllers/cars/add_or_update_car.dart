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

/// Add customer or update a car
///
/// If token expired refresh it without asking customer credentials
///
/// One parameter to know if it's for updating or not
Future addOrUpdateCar({int? idForUpdate}) async {
  //get all car variables
  Car addCarVars = Get.put(Car());
  //get all authentication variables
  Authentication authVars = Get.put(Authentication());
  //Check internet access before begining
  if (!await hasInternet()) {
    return;
  }
  //Start loading
  addCarVars.isLoading.value = true;
  try {
    //Two Request URLs, if updating car pass id in first url
    //If adding car use second url
    Uri url = Uri.parse(idForUpdate != null
        ? "https://satc.live/api/Customer/UpdaetCar?id=$idForUpdate"
        : "https://satc.live/api/Customer/AddCar");
    //Header for post request, check customer language before setting 'lng'
    //Pass token as header parameter
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
      'Authorization': 'Bearer ${authVars.bearerToken.value}'
    };
    //Request's body
    Map body = <String, dynamic>{
      "Car_Vendor_id": addCarVars.carVendorController["id"]!.value.toString(),
      "Car_Model_id": addCarVars.carModelController["id"]!.value.toString(),
      "Car_Color_id": addCarVars.carColorsController["id"]!.value.toString(),
      "Car_Models_Engine_id":
          addCarVars.carCylinderController["id"]!.value.toString(),
      "Car_Fule_Type_id": addCarVars.carFuelController["id"]!.value.toString(),
      "Model_Year": addCarVars.carProductionDateController.value.text,
      "Board_No":
          "${addCarVars.carPlateNumberController.value.text} ${addCarVars.carPlateCharactersController.value.text}",
      "Car_Lic_No": addCarVars.licenseNumberController.value.text,
      "Last_KMs_Usages": "0",
    };
    //'Post' request
    http.Response response = await http.post(url, headers: headers, body: body);
    //Decode json data
    Map dataRecieved = jsonDecode(response.body);
    //Check if the 'status' of the request is true or not
    if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
      //Call getcars function to update customer's car list
      await getCars();
      //Go directly to 'Home' scree
      var whichHome = Get.put(WhichHome());
      whichHome.whichPage.value = "Cars";
      Get.to(() => const Home());
    } else {
      //When error show customer message
      Get.snackbar("Error", dataRecieved["message"].toString());
      //Stop loading
      addCarVars.isLoading.value = false;
      return;
    }
  } on Exception catch (e) {
    //When exception log the error
    log(e.toString());
    //This if statement to analyze error
    //If error happen because of expired token; refresh the token
    if (e.toString().contains(
        "FormatException: Unexpected end of input (at character 1)")) {
      if (await refreshToken()) {
        //After refresh token recall the function
        idForUpdate != null
            ? addOrUpdateCar(idForUpdate: idForUpdate)
            : addOrUpdateCar();
      }
    }
    //Stop loading
    addCarVars.isLoading.value = false;
    return;
  }
  //Stop loading
  addCarVars.isLoading.value = false;
  return;
}
