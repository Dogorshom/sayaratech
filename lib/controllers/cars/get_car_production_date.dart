import 'package:get/get.dart';

import '../../models/car.dart';

getAllYears() async {
  Car carVars = Get.put(Car());

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
  carVars.specificResForDateOfProduction.clear();
  for (String element in allyears) {
    element = element.toLowerCase();
    if (element.contains(
        carVars.dateOfProductionController.value.text.toLowerCase())) {
      carVars.specificResForDateOfProduction.add(element.toLowerCase());
    }
  }
  if (carVars.specificResForDateOfProduction.isEmpty) {
    carVars.isSearchingForDateOfProduction.value = false;
  }
}
