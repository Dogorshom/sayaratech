import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/authentication.dart';

Future<bool> refreshToken() async {
  Authentication authVars = Get.put(Authentication());
  try {
    Uri url = Uri.parse("https://satc.live/api/Auth/Token/refreshToken");
    Map<String, String> headers = {'token': authVars.bearerToken.value};
    http.Response response = await http.post(url, headers: headers);
    Map dataRecieved = jsonDecode(response.body);
    if (dataRecieved["status"]) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      authVars.bearerToken.value = dataRecieved['Data']['token'];
      sharedPreferences.setString(
          "customer_latest_token", authVars.bearerToken.value);
      return true;
    }
  } on Exception catch (e) {
    log(e.toString());
    return false;
  }
  return false;
}
