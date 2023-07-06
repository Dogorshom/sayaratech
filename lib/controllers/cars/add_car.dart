import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:sayaratech/models/car.dart';
import 'package:sayaratech/controllers/tokens/refresh_token.dart';
import 'package:sayaratech/models/which_home.dart';
import 'package:sayaratech/pages/home/home.dart';
import '../../models/authentication.dart';
import '../../pages/my_cars/my_cars_screen.dart';
import '../internet/check_internet.dart';

/// Add customer car, If token expired refresh it without asking customer credentials
Future addCar() async {
  Car addCarVars = Get.put(Car());
  Authentication authVars = Get.put(Authentication());
  if (!await hasInternet()) {
    return;
  }
  addCarVars.isLoading.value = true;
  try {
    Uri url = Uri.parse("https://satc.live/api/Customer/AddCar");
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
      'Authorization': 'Bearer ${authVars.bearerToken.value}'
    };
    Map body = <String, dynamic>{
      "Car_Vendor_id": "5",
      "Car_Model_id": "28",
      "Car_Color_id": "2",
      "Model_Year": "2020",
      "Board_No": "3234",
      "Car_Lic_No": "3920329",
      // "Last_KMs_Usages": "0",
      "Car_Models_Engine_id": "66",
      "Car_Fule_Type_id": "1"
    };
    http.Response response = await http.post(url, headers: headers, body: body);
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());
    if (dataRecieved["status"]) {
      //If success then go to my cars screen
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
        addCar();
      }
    }
    addCarVars.isLoading.value = false;
  }
  addCarVars.isLoading.value = false;
}
