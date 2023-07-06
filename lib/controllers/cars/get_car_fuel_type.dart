import 'package:get/get.dart';

import '../../../models/car.dart';

getAllCarFuels() async {
  Car carVars = Get.put(Car());
  List<Map<String, dynamic>> colorsMap = [
    {"id": 1, "name": "بنزين", "eng_name": "Petrol"},
    {"id": 2, "name": "ديزل", "eng_name": "Diesel"},
    {"id": 3, "name": "كهربائيه", "eng_name": "Eelectric"},
    {"id": 4, "name": "هجين", "eng_name": "Hybrid"}
  ];
  carVars.specificResForCarFuel.clear();
  for (Map<String, dynamic> element in colorsMap) {
    int id = element["id"];
    element["name"] =
        element[Get.locale!.languageCode == 'en' ? "eng_name" : "name"]
            .toLowerCase();
    if (element["name"].contains(
        carVars.carFuelController["controller"]!.value.text.toLowerCase())) {
      carVars.specificResForCarFuel.add({"id": id, "name": element["name"]});
    }
  }
  if (carVars.specificResForCarFuel.isEmpty) {
    carVars.isSearchingForCarFuel.value = false;
  }
}
