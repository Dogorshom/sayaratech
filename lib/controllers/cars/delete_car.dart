import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../ui_manager/colors_manager.dart';
import '../../../models/authentication.dart';
import '../../../models/car.dart';
import '../internet/check_internet.dart';
import '../tokens/refresh_token.dart';

///Delete specific customer car
///
///Recieve: car id, and car index in the list
Future deleteCar({required int carId, required int indexInList}) async {
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
    //Request's URL, pass car id in the url
    Uri url = Uri.parse("https://satc.live/api/Customer/DeleteCar?id=$carId");
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
      //Remove car from the list using index
      carVars.carsList.removeAt(indexInList);
      //Show successful snackbar at the top
      Get.snackbar(
          "Successful Operation", "You have successfully delete your car",
          backgroundColor: greenColor.withOpacity(0.7));
      //Stop loading
      carVars.isLoading.value = false;
      return;
    } else {
      //Show error snackbar at the top
      Get.snackbar("Failed Operation", "There is something go wrong",
          backgroundColor: redColor.withOpacity(0.7));
      //Stop loading
      carVars.isLoading.value = false;
      return;
    }
    //This is just for showing that don't have cars added
  } on Exception catch (e) {
    //When exception log the error
    log(e.toString());
    //This if statement to analyze error
    //If error happen because of expired token; refresh the token
    if (e.toString().contains(
        "FormatException: Unexpected end of input (at character 1)")) {
      if (await refreshToken()) {
        //After refresh token recall the function
        deleteCar(carId: carId, indexInList: indexInList);
      }
    }
    //Stop loading
    carVars.isLoading.value = false;
    return;
  }
}
