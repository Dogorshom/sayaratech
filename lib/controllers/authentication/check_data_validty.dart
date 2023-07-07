import 'package:get/get.dart';
import '../../../models/authentication.dart';

///Check if phone number, email, and password are valid
///
///If called when [Login] then it will check phone number only
///
///Return [true] if valid and [false] otherwise
bool checkDataValidty({bool newRegister = false}) {
  //get all authentication variables
  Authentication authVars = Get.put(Authentication());
  //Check phone number
  if (authVars.phoneNumberController.value.text.length != 9 ||
      authVars.phoneNumberController.value.text.substring(0, 1) != "5") {
    if (newRegister) {
      authVars.errorMessageInRegister.value =
          "Wrong phone: Please use this format (5xxxxxxxx)";
    } else {
      authVars.errorMessageInLogin.value =
          "Wrong phone: Please use this format (5xxxxxxxx)";
    }
    return false;
  }
  if (!newRegister) {
    return true;
  }
  //Check email address
  if (authVars.emailController.value.text == "") {
    if (newRegister) {
      authVars.errorMessageInRegister.value = "Please enter your email";
    } else {
      authVars.errorMessageInLogin.value = "Please enter your email";
    }
    return false;
  }
  //Check email validity
  if (!authVars.emailController.value.text.contains("@gmail.com") &&
          !authVars.emailController.value.text.contains("@hotmail.com") &&
          !authVars.emailController.value.text.contains("@outlook.com") &&
          !authVars.emailController.value.text.contains("@yahoo.com") &&
          !authVars.emailController.value.text.contains("@live.com") ||
      authVars.emailController.value.text.length < 13) {
    if (newRegister) {
      authVars.errorMessageInRegister.value = "Please enter valid email";
    } else {
      authVars.errorMessageInLogin.value = "Please enter valid email";
    }
    return false;
  }
  //Check password
  if (authVars.passwordController.value.text.length < 8) {
    if (newRegister) {
      authVars.errorMessageInRegister.value = "Please enter a good password";
    } else {
      authVars.errorMessageInLogin.value = "Please enter a good password";
    }
    return false;
  }
  //Check if password match
  if (newRegister) {
    if (authVars.passwordController.value.text !=
        authVars.confirmPasswordController.value.text) {
      authVars.errorMessageInRegister.value = "Password doesn't match";
      return false;
    }
  }
  return true;
}
