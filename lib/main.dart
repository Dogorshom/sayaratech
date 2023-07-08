import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/authentication.dart';
import '../../pages/authentication/login_screen.dart';
import '../../pages/home/home.dart';
import 'controllers/authentication/get_local_data.dart';
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
      locale: authVars.isArabic.value
          ? const Locale('ar', 'SA')
          : const Locale('en', 'US'),
      title: 'Sayara Tech',
      defaultTransition: Transition.fadeIn,
      theme: authVars.isDarkMode.value ? darkThemeData : lightThemeData,
      themeMode: authVars.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      home: authVars.isAlreadyLoginInThisDevice.value
          ? const Home()
          : const LoginScreen(),
    );
  }
}
