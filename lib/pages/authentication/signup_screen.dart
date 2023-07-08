import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/authentication.dart';
import '../../pages/authentication/login_screen.dart';
import '../../controllers/authentication/sign_up/sign_up_first_step.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/buttons/custom_button.dart';
import '../../../ui_manager/widgets/overlays/loading_overlay.dart';
import '../../../ui_manager/widgets/text_field_container.dart';

class SignUpScreen extends StatelessWidget {
  final bool x = false;
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = Get.height;
    double width = Get.width;
    var authenticationVars = Get.put(Authentication());
    return Stack(
      children: [
        Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixedMainPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fixedSizedBoxHeight,
                    fixedSizedBoxHeight,
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "Sayara Tech".tr,
                          style: Get.textTheme.headlineMedium!
                              .copyWith(color: primaryColor)),
                      TextSpan(
                          text: "As Fast As Possible".tr,
                          style: Get.textTheme.headlineMedium)
                    ])),
                    fixedSizedBoxHeight,
                    fixedSizedBoxHeight,
                    Container(
                      height: 4,
                      width: width * 0.15,
                      color: primaryColor,
                    ),
                    fixedSizedBoxHeightBy5,
                    TextFieldContainer(
                      child: TextField(
                        controller: authenticationVars.nameController.value,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: "Name".tr,
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: secondaryColor,
                            )),
                        onChanged: (v) {
                          if (authenticationVars.errorMessageInRegister.value !=
                              "") {
                            authenticationVars.errorMessageInRegister.value =
                                "";
                          }
                        },
                      ),
                    ),
                    fixedSizedBoxHeight,
                    TextFieldContainer(
                      child: TextField(
                        controller:
                            authenticationVars.phoneNumberController.value,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Phone Number ex: 5xxxxxxxx".tr,
                            prefixIcon: Icon(
                              Icons.phone_outlined,
                              color: secondaryColor,
                            )),
                        onChanged: (v) {
                          if (authenticationVars.errorMessageInRegister.value !=
                              "") {
                            authenticationVars.errorMessageInRegister.value =
                                "";
                          }
                        },
                      ),
                    ),
                    fixedSizedBoxHeight,
                    TextFieldContainer(
                      child: TextField(
                        controller: authenticationVars.emailController.value,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Email".tr,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: secondaryColor,
                            )),
                        onChanged: (v) {
                          if (authenticationVars.errorMessageInRegister.value !=
                              "") {
                            authenticationVars.errorMessageInRegister.value =
                                "";
                          }
                        },
                      ),
                    ),
                    fixedSizedBoxHeight,
                    GetX<Authentication>(builder: (_) {
                      return Column(
                        children: [
                          TextFieldContainer(
                            child: TextField(
                              controller:
                                  authenticationVars.passwordController.value,
                              obscureText: authenticationVars
                                  .hiddenPasswordRegister.value,
                              decoration: InputDecoration(
                                  hintText: "Password".tr,
                                  prefixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: secondaryColor,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: !authenticationVars
                                            .hiddenPasswordRegister.value
                                        ? Icon(
                                            Icons.visibility_outlined,
                                            color: secondaryColor,
                                          )
                                        : const Icon(
                                            Icons.visibility_off_outlined),
                                    onPressed: () {
                                      authenticationVars
                                              .hiddenPasswordRegister.value =
                                          !authenticationVars
                                              .hiddenPasswordRegister.value;
                                    },
                                  )),
                              onChanged: (v) {
                                if (authenticationVars
                                        .errorMessageInRegister.value !=
                                    "") {
                                  authenticationVars
                                      .errorMessageInRegister.value = "";
                                }
                              },
                            ),
                          ),
                          fixedSizedBoxHeight,
                          TextFieldContainer(
                            child: TextField(
                              controller: authenticationVars
                                  .confirmPasswordController.value,
                              obscureText: authenticationVars
                                  .hiddenConfirmPassword.value,
                              decoration: InputDecoration(
                                  hintText: "Confirm Password".tr,
                                  prefixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: secondaryColor,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: !authenticationVars
                                            .hiddenConfirmPassword.value
                                        ? Icon(
                                            Icons.visibility_outlined,
                                            color: secondaryColor,
                                          )
                                        : const Icon(
                                            Icons.visibility_off_outlined),
                                    onPressed: () {
                                      authenticationVars
                                              .hiddenConfirmPassword.value =
                                          !authenticationVars
                                              .hiddenConfirmPassword.value;
                                    },
                                  )),
                              onChanged: (v) {
                                if (authenticationVars
                                        .errorMessageInRegister.value !=
                                    "") {
                                  authenticationVars
                                      .errorMessageInRegister.value = "";
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                    fixedSmallSizedBoxHeight,
                    Obx(() =>
                        authenticationVars.errorMessageInRegister.value != ""
                            ? Text(
                                authenticationVars.errorMessageInRegister.value,
                                style: Get.textTheme.bodySmall!
                                    .copyWith(color: redColor),
                              )
                            : Container()),
                    fixedSizedBoxHeight,
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Text("Can't create account?".tr),
                        onTap: () {
                          // Get.to(() => const ForgotPasswordScreen());
                        },
                      ),
                    ),
                    fixedSizedBoxHeightBy5,
                    CustomButton(
                      text: "Sign Up".tr,
                      width: Get.width,
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        await signUpFirstStep();
                      },
                    ),
                    fixedSizedBoxHeight,
                    fixedSizedBoxHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have account? ".tr),
                        InkWell(
                          onTap: () {
                            Get.to(() => const LoginScreen());
                          },
                          child: Text("Login".tr,
                              style: Get.textTheme.titleSmall!.copyWith(
                                color: primaryColor,
                              )),
                        )
                      ],
                    )
                  ],
                )),
          ),
        )),
        Obx(() => authenticationVars.isLoading.value
            ? const LoadingOverlay()
            : Container())
      ],
    );
  }
}
