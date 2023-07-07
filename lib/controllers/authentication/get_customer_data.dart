import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../../../../models/authentication.dart';
import 'package:http/http.dart' as http;
import '../internet/check_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Get customer profile data
///
///Called when login or registeration
Future getCustomerProfile() async {
  //Shared Preferences variable to save customer data locally
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //get all authentication variables
  Authentication authVars = Get.put(Authentication());
  //Check internet access before begining
  if (!await hasInternet()) {
    return;
  }
  //Start loading
  authVars.isLoading.value = true;
  try {
    //Request's URL
    Uri url = Uri.parse("https://satc.live/api/Customer/Profile");
    //Header for post request, check customer language before setting 'lng'
    //Pass token as header
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
      'Authorization': 'Bearer ${authVars.bearerToken.value}'
    };
    //'Post' request
    http.Response response = await http.post(url, headers: headers);
    //Decode json data
    Map dataRecieved = jsonDecode(response.body);
    //Check if the 'status' of the request is true or not
    if (dataRecieved["status"] != null && dataRecieved["status"]) {
      //Save customer data in authentication variables
      authVars.id.value = dataRecieved["Data"]["customer_id"];
      authVars.name.value = dataRecieved["Data"]["name"];
      authVars.username.value = dataRecieved["Data"]["username"];
      authVars.email.value = dataRecieved["Data"]["email"];
      authVars.walletBalance.value = dataRecieved["Data"]["wallet_balance"];
      authVars.numberOfActiveCars.value =
          dataRecieved["Data"]["statistics"]["no_of_active_cars"];
      authVars.phoneNumber.value = dataRecieved["Data"]["phone"];
      //Save data locally
      await sharedPreferences.setInt("customer_id", authVars.id.value);
      await sharedPreferences.setString("customer_name", authVars.name.value);
      await sharedPreferences.setString(
          "customer_username", authVars.username.value);
      await sharedPreferences.setString("customer_email", authVars.email.value);
      await sharedPreferences.setDouble(
          "customer_wallet_balance", authVars.walletBalance.value);
      await sharedPreferences.setInt(
          "customer_number_of_active_cars", authVars.numberOfActiveCars.value);
      await sharedPreferences.setString(
          "customer_phone", authVars.phoneNumber.value);
      await sharedPreferences.setString(
          "customer_latest_token", authVars.bearerToken.value);
      //Stop loading
      authVars.isLoading.value = false;
      return;
    } else {
      //When error show customer message
      Get.snackbar("Error", dataRecieved["message"].toString());
      //Stop loading
      authVars.isLoading.value = false;
      return;
    }
  } on Exception catch (e) {
    //When exception log the error
    log(e.toString());
    //Stop loading
    authVars.isLoading.value = false;
    return;
  }
}
