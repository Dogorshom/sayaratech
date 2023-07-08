import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/authentication.dart';

/// Get local customer if exist retrieve information before open the app
getUserInfoIfAvailable() async {
  //get all authentication variables
  Authentication authVars = Get.put(Authentication());
  //Shared Preferences to get local data
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //Check if the customer has a local data saved on his device
  if (sharedPreferences.getInt("customer_id") != null) {
    authVars.id.value = sharedPreferences.getInt("customer_id")!;
    authVars.name.value = sharedPreferences.getString("customer_name")!;
    authVars.username.value = sharedPreferences.getString("customer_username")!;
    authVars.email.value = sharedPreferences.getString("customer_email")!;
    authVars.walletBalance.value =
        sharedPreferences.getDouble("customer_wallet_balance")!;
    authVars.numberOfActiveCars.value =
        sharedPreferences.getInt("customer_number_of_active_cars")!;
    authVars.phoneNumber.value = sharedPreferences.getString("customer_phone")!;
    authVars.bearerToken.value =
        sharedPreferences.getString("customer_latest_token")!;
    authVars.isAlreadyLoginInThisDevice.value = true;
  } else {
    authVars.isAlreadyLoginInThisDevice.value = false;
  }
  if (sharedPreferences.getBool("isDarkMode") != null) {
    authVars.isDarkMode.value = sharedPreferences.getBool("isDarkMode")!;
  }
  if (sharedPreferences.getBool("isArabic") != null) {
    authVars.isArabic.value = sharedPreferences.getBool("isArabic")!;
  }
}
