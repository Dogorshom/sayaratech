import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/authentication/login/login_first_step.dart';
import '../../../models/authentication.dart';
import '../../pages/authentication/signup_screen.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/buttons/custom_button.dart';
import '../../../ui_manager/widgets/overlays/loading_overlay.dart';
import '../../../ui_manager/widgets/text_field_container.dart';

class LoginScreen extends StatelessWidget {
  final bool x = false;
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = Get.height;
    double width = Get.width;
    var registerVars = Get.put(Authentication());
    return Stack(
      children: [
        Scaffold(
            body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: fixedMainPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  fixedSizedBoxHeight,
                  fixedSizedBoxHeight,
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "Sayara Tech",
                        style: Get.textTheme.headlineMedium!
                            .copyWith(color: primaryColor)),
                    TextSpan(
                        text: ", As Fast As Possible",
                        style: Get.textTheme.headlineMedium)
                  ])),
                  fixedSizedBoxHeight,
                  fixedSizedBoxHeight,
                  Container(
                    height: 4,
                    width: width * 0.15,
                    color: primaryColor,
                  ),
                  fixedSizedBoxHeight,
                  fixedSizedBoxHeight,
                  const Text(
                      "Wash your car, change car tires, and more at Home!"),
                  fixedSizedBoxHeightBy5,
                  Center(
                    child: Text(
                      "We will send code to your phone",
                      style: Get.textTheme.bodySmall,
                    ),
                  ),
                  fixedSmallSizedBoxHeight,
                  TextFieldContainer(
                    child: TextField(
                      controller: registerVars.phoneNumberController.value,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: "Phone number",
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color: secondaryColor,
                          )),
                      onChanged: (v) {
                        if (registerVars.errorMessageInLogin.value != "") {
                          registerVars.errorMessageInLogin.value = "";
                        }
                      },
                    ),
                  ),
                  // fixedSizedBoxHeight,
                  // fixedSizedBoxHeight,
                  // GetX<Authentication>(builder: (_) {
                  //   return TextFieldContainer(
                  //     child: TextField(
                  //       controller: registerVars.passwordController.value,
                  //       obscureText: registerVars.hiddenPasswordLogin.value,
                  //       decoration: InputDecoration(
                  //           hintText: "Password",
                  //           prefixIcon: Icon(
                  //             Icons.lock_outline_rounded,
                  //             color: secondaryColor,
                  //           ),
                  //           suffixIcon: IconButton(
                  //             icon: !registerVars.hiddenPasswordLogin.value
                  //                 ? Icon(
                  //                     Icons.visibility_outlined,
                  //                     color: secondaryColor,
                  //                   )
                  //                 : const Icon(Icons.visibility_off_outlined),
                  //             onPressed: () {
                  //               registerVars.hiddenPasswordLogin.value =
                  //                   !registerVars.hiddenPasswordLogin.value;
                  //             },
                  //           )),
                  //       onChanged: (v) {
                  //         if (registerVars.errorMessageInLogin.value != "") {
                  //           registerVars.errorMessageInLogin.value = "";
                  //         }
                  //       },
                  //     ),
                  //   );
                  // }),
                  fixedSmallSizedBoxHeight,
                  Obx(() => registerVars.errorMessageInLogin.value != ""
                      ? Text(
                          registerVars.errorMessageInLogin.value,
                          style: Get.textTheme.bodySmall!
                              .copyWith(color: redColor),
                        )
                      : Container()),
                  // fixedSizedBoxHeight,
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: InkWell(
                  //     child: const Text("Forgot Password?"),
                  //     onTap: () {
                  //       // Get.to(() => const ForgotPasswordScreen());
                  //     },
                  //   ),
                  // ),
                  fixedSizedBoxHeightBy5,
                  CustomButton(
                    text: "Send Code",
                    width: Get.width,
                    onTap: () async {
                      await loginFirstStep();
                    },
                  ),
                  fixedSizedBoxHeight,
                  fixedSizedBoxHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      InkWell(
                        onTap: () {
                          Get.to(() => const SignUpScreen());
                        },
                        child: Text("Register Now",
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: primaryColor,
                                decoration: TextDecoration.underline)),
                      )
                    ],
                  )
                ],
              )),
        )),
        Obx(() =>
            registerVars.isLoading.value ? const LoadingOverlay() : Container())
      ],
    );
  }
}
