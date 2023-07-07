import 'package:get/get.dart';
import '../../pages/authentication/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Logout from the application and wipe data
logout() async {
  //Shared preferences to delete local data
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //Delete all local data
  sharedPreferences.clear();
  //Delete all 'Get' package data
  Get.deleteAll();
  //Go directly to Login screen
  Get.to(() => const LoginScreen());
}
