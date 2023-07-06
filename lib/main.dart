import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sayaratech/models/authentication.dart';
import 'package:sayaratech/pages/authentication/login_screen.dart';
import 'package:sayaratech/pages/home/home.dart';
import 'package:sayaratech/pages/profile/sub_pages/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/language/languages.dart';
import 'ui_manager/themes/dark_theme.dart';
import 'ui_manager/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getUserInfoIfAvailable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Authentication authVars = Get.put(Authentication());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      fallbackLocale: const Locale('en', 'US'),
      darkTheme: darkThemeData,
      locale: const Locale('en', 'US'),
      title: 'Sayara Tech',
      defaultTransition: Transition.fadeIn,
      theme: lightThemeData,
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: authVars.isAlreadyLoginInThisDevice.value
          ? const Home()
          : const LoginScreen(),
    );
  }
}

getUserInfoIfAvailable() async {
  Authentication authVars = Get.put(Authentication());
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getInt("customer_id") != null) {
    authVars.id.value = sharedPreferences.getInt("customer_id")!;
    authVars.name.value = sharedPreferences.getString("customer_name")!;
    authVars.username.value = sharedPreferences.getString("customer_username")!;
    authVars.email.value = sharedPreferences.getString("customer_email")!;
    authVars.walletBalance.value =
        sharedPreferences.getDouble("customer_wallet_balance")!;
    authVars.numberOfActiveCars.value =
        sharedPreferences.getInt("customer_number_of_active_cars")!;
    authVars.phoneNumber.value = sharedPreferences.getString("customer_phone")!;
    authVars.bearerToken.value =
        sharedPreferences.getString("customer_latest_token")!;
    authVars.isAlreadyLoginInThisDevice.value = true;
  } else {
    authVars.isAlreadyLoginInThisDevice.value = false;
  }
}
