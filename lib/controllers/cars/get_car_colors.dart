import 'package:get/get.dart';

import '../../models/car.dart';

getAllColorsAvailable() async {
  Car carVars = Get.put(Car());
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
  // List<String> allColors = ["Yellow", "Red", "Green", "Grey", "White", "Black"];
  carVars.specificResForCarColors.clear();
  for (Map<String, dynamic> element in colorsMap) {
    int id = element["id"];
    element["name"] =
        element[Get.locale!.languageCode == 'en' ? "eng_name" : "name"]
            .toLowerCase();
    if (element["name"].contains(
        carVars.carColorsController["controller"]!.value.text.toLowerCase())) {
      carVars.specificResForCarColors.add({"id": id, "name": element["name"]});
    }
  }
  if (carVars.specificResForCarColors.isEmpty) {
    carVars.isSearchingForCarColors.value = false;
  }
}
