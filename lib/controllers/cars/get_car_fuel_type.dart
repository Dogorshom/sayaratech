import 'package:get/get.dart';
import '../../../models/car.dart';

///Get all car fuels types list
getCarFuelTypes() async {
  //get all car variables
  Car carVars = Get.put(Car());
  //Fuels map that linking fule type with Ids
  List<Map<String, dynamic>> fuelTypes = [
    {"id": 1, "name": "بنزين", "eng_name": "Petrol"},
    {"id": 2, "name": "ديزل", "eng_name": "Diesel"},
    {"id": 3, "name": "كهربائيه", "eng_name": "Eelectric"},
    {"id": 4, "name": "هجين", "eng_name": "Hybrid"}
  ];
  //Clear list before refreshing the list
  carVars.specificResForCarFuel.clear();
  //Start loop to add colors in the list
  for (Map<String, dynamic> fuel in fuelTypes) {
    fuel["name"] = fuel[Get.locale!.languageCode == 'en' ? "eng_name" : "name"]
        .toLowerCase();
    //If fuel type name contains the entered string add it to the list
    if (fuel["name"].contains(
        carVars.carFuelController["controller"]!.value.text.toLowerCase())) {
      carVars.specificResForCarFuel
          .add({"id": fuel["id"], "name": fuel["name"]});
    }
  }
  if (carVars.specificResForCarFuel.isEmpty) {
    carVars.isSearchingForCarFuel.value = false;
  }
}
