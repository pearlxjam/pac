// ignore_for_file: unnecessary_null_comparison

import 'package:location/location.dart';

Location location = Location();

Future<bool> checkPermisos() async {
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  // LocationData locationData;
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return false;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return false;
    }
  }
  return true;
}

Future<double> getLatitud() async {
  LocationData locationData;
  locationData = await location.getLocation();
  double latitud;
  if (locationData != null) {
    latitud = locationData.latitude!;
  } else {
    latitud = 0.0;
  }
  return latitud;
}

Future<double> getLongitud() async {
  LocationData locationData;
  locationData = await location.getLocation();
  double longitud;
  if (locationData != null) {
    longitud = locationData.longitude!;
  } else {
    longitud = 0.0;
  }
  return longitud;
}
