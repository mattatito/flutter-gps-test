
import 'package:geolocator/geolocator.dart';
import 'package:gps_test/permission_enum.dart';
import 'package:gps_test/position_model.dart';

abstract class LocationClient {
  Future<PositionModel> fetchCurrentPosition();
  Future<GeoLocationPermissionEnum> requestLocationPermission();
}

class GeoLocationClient implements LocationClient {
  @override
  Future<PositionModel> fetchCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    return PositionModel(
      latitude: position.latitude,
      longitude: position.longitude
    );
  }

  @override
  Future<GeoLocationPermissionEnum> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return GeoLocationPermissionEnum.serviceNotAvailable;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return GeoLocationPermissionEnum.denied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return GeoLocationPermissionEnum.deniedForever;
    }
    return GeoLocationPermissionEnum.allowed;
  }

}