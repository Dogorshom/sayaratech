import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../../../../models/authentication.dart';
import '../../../pages/authentication/verify_phone_screen.dart';
import '../../internet/check_internet.dart';
import '../check_data_validty.dart';
import 'package:http/http.dart' as http;

///Register step 1 using phone number, name, email, and password
///
///If [success] go to [VerifyPhone] page directly, If [fail] show the error
Future signUpFirstStep() async {
  //get all authentication variables
  Authentication authVars = Get.put(Authentication());
  //Check data validity before starting
  if (checkDataValidty(newRegister: true)) {
    //Check internet access before begining
    if (!await hasInternet()) {
      return;
    }
    //Start loading
    authVars.isLoading.value = true;
    try {
      //Request's URL
      Uri url = Uri.parse(
          "https://satc.live/api/General/Customers/NewRegistrationStep1");
      //Request's body
      Map body = <String, String>{
        "name": authVars.nameController.value.text,
        "pwd": authVars.passwordController.value.text,
        "email": authVars.emailController.value.text,
        "mobile": authVars.phoneNumberController.value.text
      };
      //Header for post request, check customer language before setting 'lng'
      Map<String, String> headers = {
        'lng': Get.locale!.languageCode == 'en' ? 'en' : 'ar',
      };
      //'Post' request
      http.Response response =
          await http.post(url, headers: headers, body: body);
      //Decode json data
      Map dataRecieved = jsonDecode(response.body);
      //Check if the 'status' of the request is true or not
      if (dataRecieved["status"] != null && dataRecieved["status"] == true) {
        //Saving step 1 Id for step 2
        authVars.step1Id.value = dataRecieved["Data"]["id_step2"];
        //Saving Sms code
        authVars.smsCodeFromHttp.value = dataRecieved["Data"]["smscode"];
        //After finished go to 'Verify Phone' page
        Get.to(() => const VerifyPhoneNumberScreen(isForLogin: false));
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
}
