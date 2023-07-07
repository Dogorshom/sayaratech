import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/authentication.dart';
import '../../../ui_manager/colors_manager.dart';
import '../../../ui_manager/fixed_numbers_manager.dart';
import '../../../ui_manager/sized_box_manager.dart';
import '../../../ui_manager/widgets/text_field_container.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Authentication authVars = Get.put(Authentication());
    // authVars.numberOfActiveCars.value = 20;
    print(authVars.numberOfActiveCars.value);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile".tr),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: fixedMainPadding),
        child: Column(
          children: [
            fixedSizedBoxHeight,
            fixedSizedBoxHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.wallet,
                      size: 30,
                      color: primaryColor,
                    ),
                    fixedSmallSizedBoxWidth,
                    Text(
                      authVars.walletBalance.value.toString(),
                      style: Get.textTheme.titleLarge,
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.car_rental_sharp,
                      size: 30,
                      color: primaryColor,
                    ),
                    fixedSmallSizedBoxWidth,
                    Text(
                      authVars.numberOfActiveCars.value.toString(),
                      style: Get.textTheme.titleLarge,
                    )
                  ],
                ),
              ],
            ),
            fixedSizedBoxHeight,
            fixedSizedBoxHeight,
            TextFieldContainer(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(hintText: authVars.name.value),
              ),
            ),
            fixedSizedBoxHeight,
            TextFieldContainer(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(hintText: authVars.email.value),
              ),
            ),
            fixedSizedBoxHeight,
            TextFieldContainer(
              child: TextField(
                enabled: false,
                decoration:
                    InputDecoration(hintText: authVars.phoneNumber.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
