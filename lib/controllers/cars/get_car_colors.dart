import 'package:get/get.dart';
import '../../../models/car.dart';

///Get all colors available list
getCarColors() async {
  //get all car variables
  Car carVars = Get.put(Car());
  //Colors map that linking colors and Ids
  List<Map<String, dynamic>> colorsMap = [
    {"id": 1, "name": "ابيض ", "eng_name": "White"},
    {"id": 2, "name": "اسود", "eng_name": "Black"},
    {"id": 3, "name": "رمادي", "eng_name": "Gray"},
    {"id": 4, "name": "بني", "eng_name": "brown"},
    {"id": 5, "name": "احمر", "eng_name": "Red"},
    {"id": 6, "name": "فضي", "eng_name": "Silver"},
    {"id": 7, "name": "اخضر", "eng_name": "Green"},
    {"id": 8, "name": "ذهبي", "eng_name": "Gold"},
    {"id": 9, "name": "ازرق", "eng_name": "Blue"},
    {"id": 11, "name": "زيتي", "eng_name": "Bright Green"}
  ];
  //Clear list before refreshing the list
  carVars.specificResForCarColors.clear();
  //Start loop to add colors in the list
  for (Map<String, dynamic> color in colorsMap) {
    color["name"] =
        color[Get.locale!.languageCode == 'en' ? "eng_name" : "name"]
            .toLowerCase();
    //If color name contains the entered string add it to the list
    if (color["name"].contains(
        carVars.carColorsController["controller"]!.value.text.toLowerCase())) {
      carVars.specificResForCarColors
          .add({"id": color["id"], "name": color["name"]});
    }
  }
  if (carVars.specificResForCarColors.isEmpty) {
    carVars.isSearchingForCarColors.value = false;
  }
}
