import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:sayaratech/models/which_home.dart';
import '../../../controllers/authentication/get_customer_data.dart';
import '../../../pages/home/home.dart';
import '../../../../models/authentication.dart';
import '../../internet/check_internet.dart';
import 'package:http/http.dart' as http;

///Login step 2 by verifying user code
///
///If [success] go to [HomeScreen] directly, If [fail] show the error
Future loginSecondStep() async {
  //get all authentication variables
  Authentication authVars = Get.put(Authentication());
  //Check internet access before begining
  if (!await hasInternet()) {
    return;
  }
  //Start loading
  authVars.isLoading.value = true;
  try {
    //Request's URL, passing phone number, step 1 id, and sms code
    Uri url = Uri.parse(
        "https://satc.live/api/Auth/Token/AuthenticateBySMSStep2?mobileno=966${authVars.phoneNumberController.value.text}&step1id=${authVars.step1Id}&smscode=${authVars.smsCodeController.value.text}");
    //Header for post request, check customer language before setting 'lng'
    Map<String, String> headers = {
      'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
    };
    //'Post' request
    http.Response response = await http.post(url, headers: headers);
    //Decode json data
    Map dataRecieved = jsonDecode(response.body);
    log(dataRecieved.toString());
    //Check if the 'status' of the request is true or not
    if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
      //Save token for retreiving customer data
      authVars.bearerToken.value = dataRecieved["Data"];
      //Get customer profile data then go directly to 'Home' screen
      await getCustomerProfile().then((value) {
        WhichHome whichHome = Get.put(WhichHome());
        whichHome.whichPage.value = "HomeScreen";
        Get.to(() => const Home());
      });
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
  //Stop loading
  authVars.isLoading.value = false;
  return;
}
