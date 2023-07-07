import 'package:flutter/material.dart';
import 'package:get/get.dart';

///All authentication variables that will be used globally over the application
class Authentication extends GetxController {
  //Customer Id
  Rx<int> id = 0.obs;
  //Customer Full Name
  Rx<String> name = "".obs;
  //Customer Username
  Rx<String> username = "".obs;
  //Customer emalil address
  Rx<String> email = "".obs;
  //Customer wallet balance
  Rx<double> walletBalance = (0.0).obs;
  //Number of active cars that customer have
  Rx<int> numberOfActiveCars = 0.obs;
  //Custmer phone number
  Rx<String> phoneNumber = "".obs;
  //Any phone number error that will be showed in app as UI
  Rx<String> phoneNumberError = "".obs;
  //Any error in login process number error that will be showed in app as UI
  Rx<String> errorMessageInLogin = "".obs;
  //Any error in register process number error that will be showed in app as UI
  Rx<String> errorMessageInRegister = "".obs;
  //Sms code that user entered
  Rx<String> smsCode = "".obs;
  //Customer token for requests
  Rx<String> bearerToken = "".obs;
  //Sms code that recieved from http request
  Rx<String> smsCodeFromHttp = "".obs;
  //Step 1 Id that recieved in step 1 login or register
  Rx<int> step1Id = 0.obs;
  //Check if customer already login or not
  Rx<bool> isAlreadyLoginInThisDevice = false.obs;
  //When loading set it to true
  Rx<bool> isLoading = false.obs;
  //Hidden password controller
  Rx<bool> hiddenPasswordRegister = true.obs;
  //Hidden confirm Password controller
  Rx<bool> hiddenConfirmPassword = true.obs;
  //Name text controller
  Rx<TextEditingController> nameController = TextEditingController().obs;
  //Sms code text controller
  Rx<TextEditingController> smsCodeController = TextEditingController().obs;
  //Phone number text controller
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  //Email text controller
  Rx<TextEditingController> emailController = TextEditingController().obs;
  //Password text controller
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  //Confirm password text controller
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
}
