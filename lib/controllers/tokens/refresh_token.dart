import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/authentication.dart';

/// Refresh Token when expired
///
/// Return `true` if token refreshed successfully and `false` otherwise
Future<bool> refreshToken() async {
  //get all authentication variables
  Authentication authVars = Get.put(Authentication());
  try {
    //Request's URL
    Uri url = Uri.parse("https://satc.live/api/Auth/Token/refreshToken");
    //Header for post request, pass previous token
    Map<String, String> headers = {'token': authVars.bearerToken.value};
    //'Post' request
    http.Response response = await http.post(url, headers: headers);
    //Decode json data
    Map dataRecieved = jsonDecode(response.body);
    //Check if the 'status' of the request is true or not
    if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
      //Shared Preferences to save new token locally
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      //Save new token just in this session
      authVars.bearerToken.value = dataRecieved['Data']['token'];
      //Save locally to the device
      sharedPreferences.setString(
          "customer_latest_token", authVars.bearerToken.value);
      return true;
    }
  } on Exception catch (e) {
    //log the error
    log(e.toString());
    return false;
  }
  return false;
}
