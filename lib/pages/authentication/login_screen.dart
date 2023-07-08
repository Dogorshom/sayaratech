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
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var registerVars = Get.put(Authentication());
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
                      width: Get.width * 0.15,
                      color: primaryColor,
                    ),
                    fixedSizedBoxHeight,
                    fixedSizedBoxHeight,
                    Text("Services Available".tr),
                    fixedSizedBoxHeightBy5,
                    Center(
                      child: Text(
                        "Send Code Sentence".tr,
                        style: Get.textTheme.bodySmall,
                      ),
                    ),
                    fixedSmallSizedBoxHeight,
                    Center(
                      child: Text(
                        "Accepted Format Sentence".tr,
                        style: Get.textTheme.bodySmall,
                      ),
                    ),
                    fixedSmallSizedBoxHeight,
                    TextFieldContainer(
                      child: TextField(
                        controller: registerVars.phoneNumberController.value,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Phone Number".tr,
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
                    fixedSmallSizedBoxHeight,
                    Obx(() => registerVars.errorMessageInLogin.value != ""
                        ? Text(
                            registerVars.errorMessageInLogin.value,
                            style: Get.textTheme.bodySmall!
                                .copyWith(color: redColor),
                          )
                        : Container()),
                    fixedSizedBoxHeightBy5,
                    CustomButton(
                      text: "Send Code".tr,
                      width: Get.width,
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        await loginFirstStep();
                      },
                    ),
                    fixedSizedBoxHeight,
                    fixedSizedBoxHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No Account Sentence".tr),
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.to(() => const SignUpScreen());
                          },
                          child: Text("Register Now".tr,
                              style: Get.textTheme.titleSmall!
                                  .copyWith(color: primaryColor)),
                        )
                      ],
                    )
                  ],
                )),
          ),
        )),
        Obx(() =>
            registerVars.isLoading.value ? const LoadingOverlay() : Container())
      ],
    );
  }
}
