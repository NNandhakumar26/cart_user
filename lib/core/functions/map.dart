import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

LatLng startLocation = const LatLng(27.7089427, 85.3086209);
final TextEditingController startTextController = TextEditingController();
LocationData? endLocationData;
Future<String> getLocation() async {
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  Location location = Location();

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return "";
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return "";
    }
  }

  endLocationData = await location.getLocation();
  startLocation =
      LatLng(endLocationData!.latitude!, endLocationData!.longitude!);

  List<Placemark> placemarks = await placemarkFromCoordinates(
      endLocationData!.latitude!, endLocationData!.longitude!);
  Placemark place = placemarks[0];
  startTextController.text =
      //'${placemarks.first.thoroughfare}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.postalCode}';
      " ${placemarks.first.street}  ${placemarks.first.locality},  ${placemarks.first.postalCode}";

  return startTextController.text;
}

// Future<String> getLocation(LocationData data) async {
  
// }

// getLocation1() async {
//   await Geolocator.openAppSettings();
//   await Geolocator.openLocationSettings();
//   LocationPermission permission = await Geolocator.requestPermission();
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//   print('location: ${position.latitude}');

//   List<Placemark> placemarks =
//       await placemarkFromCoordinates(position.latitude, position.longitude);
//   // await placemarkFromCoordinates(12.058183, 79.547626);
//   print(placemarks);
//   // final coordinates = new Coordinates(position.latitude, position.longitude);
//   String palcename =
//       "${placemarks.first.administrativeArea}, ${placemarks.first.street}";
//   // var first = addresses.first;
//   print(palcename);

//   double distanceInMeters = Geolocator.distanceBetween(
//       12.058183, 79.547626, position.latitude, position.longitude);
//   double distanceInKiloMeters = distanceInMeters / 1000;
//   double roundDistanceInKM =
//       double.parse((distanceInKiloMeters).toStringAsFixed(2));
//   return '${placemarks.first.thoroughfare}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.postalCode}';
// }
