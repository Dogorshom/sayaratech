import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:sayaratech/models/which_home.dart';
import '../../../controllers/authentication/get_customer_data.dart';
import '../../../pages/home/home.dart';
import '../../../../models/authentication.dart';
import '../../internet/check_internet.dart';
import 'package:http/http.dart' as http;

///Login second step by verifying user code
///
///If [success] go to [HomeScreen] directly, If [fail] show the error
Future loginSecondStep() async {
  Authentication authVars = Get.put(Authentication());

  if (!await hasInternet()) {
    return;
  }
  authVars.isLoading.value = true;
  try {
    Uri url = Uri.parse(
        "https://satc.live/api/Auth/Token/AuthenticateBySMSStep2?mobileno=966${authVars.phoneNumberController.value.text}&step1id=${authVars.step1Id}&smscode=${authVars.smsCodeController.value.text}");
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
    };
    http.Response response = await http.post(url, headers: headers);
    Map dataRecieved = jsonDecode(
      response.body,
    );
    log(dataRecieved.toString());
    if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
      authVars.bearerToken.value = dataRecieved["Data"];
      await getCustomerProfile().then((value) {
        WhichHome whichHome = Get.put(WhichHome());
        whichHome.whichPage.value = "HomeScreen";
        Get.to(() => const Home());
      });
    } else {
      Get.snackbar("Error", dataRecieved["message"].toString());
    }
  } on Exception catch (e) {
    log(e.toString());
    authVars.isLoading.value = false;
  }
  authVars.isLoading.value = false;
}
