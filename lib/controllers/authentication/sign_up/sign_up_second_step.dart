import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../../../pages/home/home.dart';
import '../../../../models/authentication.dart';
import '../../internet/check_internet.dart';
import 'package:http/http.dart' as http;
import '../get_customer_data.dart';

///Sign Up second step by verifying user code
///
///If [success] go to [HomeScreen] directly, If [fail] show the error
Future signUpSecondStep() async {
  Authentication authVars = Get.put(Authentication());
  if (!await hasInternet()) {
    return;
  }
  authVars.isLoading.value = true;
  try {
    Uri url = Uri.parse(
        "https://satc.live/api/General/Customers/NewRegistrationStep2");
    Map body = <String, dynamic>{
      "step1id": authVars.step1Id.value,
      "smscode": authVars.smsCodeController.value.text,
    };
    http.Response response = await http.post(url, body: body);
    Map dataRecieved = jsonDecode(response.body);
    if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
      authVars.bearerToken.value = dataRecieved["Data"];
      await getCustomerProfile().then((value) {
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
