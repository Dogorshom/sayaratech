import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/authentication/login/login_second_step.dart';
import '../../../models/authentication.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/buttons/custom_button.dart';
import '../../../ui_manager/widgets/text_field_container.dart';

import '../../controllers/authentication/sign_up/sign_up_second_step.dart';
import '../../../ui_manager/widgets/overlays/loading_overlay.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  final bool isForLogin;
  const VerifyPhoneNumberScreen({super.key, required this.isForLogin});

  @override
  Widget build(BuildContext context) {
    Authentication authVars = Get.put(Authentication());
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Verify Your Phone"),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: fixedMainPadding),
              child: Column(
                children: [
                  fixedSizedBoxHeight,
                  fixedSizedBoxHeight,
                  Text(
                    "We have sent a code to your phone number: ${authVars.phoneNumberController.value.text}",
                    textAlign: TextAlign.center,
                    style: Get.textTheme.bodyLarge,
                  ),
                  fixedSizedBoxHeight,
                  fixedSizedBoxHeight,
                  fixedSizedBoxHeight,
                  TextFieldContainer(
                      child: TextField(
                    controller: authVars.smsCodeController.value,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(letterSpacing: 25),
                    decoration: const InputDecoration(
                      hintText: " 0 0 0 0",
                    ),
                  )),
                  fixedSizedBoxHeightBy5,
                  CustomButton(
                    text: "Verify",
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      isForLogin
                          ? await loginSecondStep()
                          : await signUpSecondStep();
                    },
                    width: Get.width,
                  )
                ],
              ),
            ),
          ),
        ),
        Obx(() =>
            authVars.isLoading.value ? const LoadingOverlay() : Container())
      ],
    );
  }
}
