// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class Getlocation extends ChangeNotifier {
  String location = "";
  static Future<Address> getlocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      return Address();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      final coordinates =
          Coordinates(currentPosition.latitude, currentPosition.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var address = addresses.first;
      // print("sgdh ${addresses.first.countryName}");
      return address;
    }
  }
}
