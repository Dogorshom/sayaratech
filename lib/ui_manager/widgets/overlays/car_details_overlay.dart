import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/car.dart';

///Car Details Widget to show one car details
///
///Need a Car to preview
Widget carDetailsColumn(Car mycar) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            "Id: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carId}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Vendor Id: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carVendorId}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Vendor Name: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carVendorName}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Model Id: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carModelId}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Mode Name: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carModel}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Color id: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carColorId}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Color Name: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carColor}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Model Year: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carProductionDate}"),
        ],
      ),
      Row(
        children: [
          Text(
            "License: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carLicenseNumber}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Plate: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carPlateNumber} ${mycar.carPlateCharacters}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Fuel Type: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.carFuel}"),
        ],
      ),
      Row(
        children: [
          Text(
            "Cylinder Id: ",
            style: Get.textTheme.titleSmall,
          ),
          Text("${mycar.cylinderId}"),
        ],
      ),
    ],
  );
}
