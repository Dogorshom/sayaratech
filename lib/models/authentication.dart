import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Authentication extends GetxController {
  Rx<int> id = 0.obs;
  Rx<String> name = "".obs;
  Rx<String> username = "".obs;
  Rx<String> email = "".obs;
  Rx<double> walletBalance = (0.0).obs;
  Rx<int> numberOfActiveCars = 0.obs;
  Rx<String> phoneNumber = "".obs;
  Rx<String> phoneNumberError = "".obs;
  Rx<String> errorMessageInLogin = "".obs;
  Rx<String> errorMessageInRegister = "".obs;
  Rx<String> smsCode = "".obs;
  Rx<String> bearerToken = "".obs;
  Rx<String> smsCodeFromHttp = "".obs;
  Rx<int> step1Id = 0.obs;
  Rx<bool> isAlreadyLoginInThisDevice = false.obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isLogin = false.obs;
  Rx<bool> hiddenPasswordLogin = true.obs;
  Rx<bool> hiddenPasswordRegister = true.obs;
  Rx<bool> hiddenConfirmPassword = true.obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> smsCodeController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
  // updateStringValuesByControllers() {
  //   name.value = nameController.value.value.text;
  //   email.value = emailController.value.value.text;
  //   phoneNumber.value = phoneNumberController.value.value.text;
  // }
}
