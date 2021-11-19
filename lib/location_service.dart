
import 'package:gps_test/location_client.dart';
import 'package:gps_test/location_errors.dart';
import 'package:gps_test/permission_enum.dart';
import 'package:gps_test/position_model.dart';

abstract class LocationService {
  Future<PositionModel> get currentPosition;
}

class LocationServiceImpl implements LocationService{

  final LocationClient _locationClient;

  static PositionModel? _currentPosition;

  LocationServiceImpl(this._locationClient);

  @override
  Future<PositionModel> get currentPosition async {
    final permission = await _locationClient.requestLocationPermission();
    _handlePermission(permission);
    _currentPosition ??= await _locationClient.fetchCurrentPosition();
    return _currentPosition!;
  }

  void _handlePermission(GeoLocationPermissionEnum permission){
    switch(permission){
      case GeoLocationPermissionEnum.denied:
        throw LocationDeniedException();
      case GeoLocationPermissionEnum.deniedForever:
        throw LocationDeniedForeverException();
      case GeoLocationPermissionEnum.serviceNotAvailable:
        throw LocationServiceNotAvailableException();
      default:
        return;
    }
  }

}