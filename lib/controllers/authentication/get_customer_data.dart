import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../../../models/authentication.dart';
import '../../../pages/authentication/verify_phone_screen.dart';

import 'package:http/http.dart' as http;
import '../internet/check_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Get customer profile data
///
///Called when login or registeration
Future getCustomerProfile() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Authentication authVars = Get.put(Authentication());
  if (!await hasInternet()) {
    return;
  }
  authVars.isLoading.value = true;
  try {
    Uri url = Uri.parse("https://satc.live/api/Customer/Profile");
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
      'Authorization': 'Bearer ${authVars.bearerToken.value}'
    };
    http.Response response = await http.post(url, headers: headers);
    Map dataRecieved = jsonDecode(response.body);
    if (dataRecieved["status"] != null && dataRecieved["status"]) {
      authVars.id.value = dataRecieved["Data"]["customer_id"];
      authVars.name.value = dataRecieved["Data"]["name"];
      authVars.username.value = dataRecieved["Data"]["username"];
      authVars.email.value = dataRecieved["Data"]["email"];
      authVars.walletBalance.value = dataRecieved["Data"]["wallet_balance"];
      authVars.numberOfActiveCars.value =
          dataRecieved["Data"]["statistics"]["no_of_active_cars"];
      authVars.phoneNumber.value = dataRecieved["Data"]["phone"];
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
    } else {
      Get.snackbar("Error", dataRecieved["message"].toString());
      authVars.isLoading.value = false;
    }
  } on Exception catch (e) {
    log(e.toString());
    authVars.isLoading.value = false;
  }
  authVars.isLoading.value = false;
}
