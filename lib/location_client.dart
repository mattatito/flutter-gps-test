
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

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return GeoLocationPermissionEnum.serviceNotAvailable;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return GeoLocationPermissionEnum.denied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return GeoLocationPermissionEnum.deniedForever;
    }
    return GeoLocationPermissionEnum.allowed;
  }

}