import 'package:geocoding/geocoding.dart';

class GoogleMapsUtilities{

  Future<Map<String, double>> convertAddressToCoordinates(String address) async {
  try {
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      double latitude = locations.first.latitude;
      double longitude = locations.first.longitude;
      return {'latitude': latitude, 'longitude': longitude};
    } else {
      return {'latitude': 0.0, 'longitude': 0.0};
    }
  } catch (e) {
    return {'latitude': 0.0, 'longitude': 0.0};
  }
}

}