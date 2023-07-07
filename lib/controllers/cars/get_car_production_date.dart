import 'package:get/get.dart';
import '../../../models/car.dart';

///Get all years available list
getAllYears() async {
  //get all car variables
  Car carVars = Get.put(Car());
  //All years list
  List<String> allyears = [
    "2023",
    "2022",
    "2021",
    "2020",
    "2019",
    "2018",
    "2017",
    "2016",
    "2015",
    "2014",
    "2013",
    "2012",
    "2011",
    "2010",
  ];
  //Clear list before refreshing the list
  carVars.specificResForDateOfProduction.clear();
  //Start loop to add years in the list
  for (String year in allyears) {
    year = year.toLowerCase();
    //If year contains the entered string add it to the list
    if (year.contains(
        carVars.dateOfProductionController.value.text.toLowerCase())) {
      carVars.specificResForDateOfProduction.add(year.toLowerCase());
    }
  }
  if (carVars.specificResForDateOfProduction.isEmpty) {
    carVars.isSearchingForDateOfProduction.value = false;
  }
}
