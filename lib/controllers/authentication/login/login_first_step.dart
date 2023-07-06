import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../../../models/authentication.dart';
import '../../../pages/authentication/verify_phone_screen.dart';
import '../../internet/check_internet.dart';
import '../check_data_validty.dart';
import 'package:http/http.dart' as http;

///Login using phone number
///
///If [success] go to [HomeScreen] directly, If [fail] show the error
Future loginFirstStep() async {
  Authentication authVars = Get.put(Authentication());
  if (checkDataValidty(newRegister: false)) {
    if (!await hasInternet()) {
      return;
    }
    authVars.isLoading.value = true;
    try {
      Uri url = Uri.parse(
          "https://satc.live/api/Auth/Token/AuthenticateBySMSStep1?mobileno=966${authVars.phoneNumberController.value.text}");
      Map<String, String> headers = {
        'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
      };
      http.Response response = await http.post(url, headers: headers);
      Map dataRecieved = jsonDecode(response.body);
      if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
        authVars.step1Id.value = dataRecieved["Data"]["id_step2"];
        authVars.smsCodeFromHttp.value = dataRecieved["Data"]["smscode"];
        Get.to(() => const VerifyPhoneNumberScreen(
              isForLogin: true,
            ));
      } else {
        Get.snackbar("Error", dataRecieved["message"].toString());
      }
    } on Exception catch (e) {
      log(e.toString());
      authVars.isLoading.value = false;
    }

    authVars.isLoading.value = false;
  }
}
