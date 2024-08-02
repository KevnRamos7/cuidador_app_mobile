import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';

class MapsUtilities{

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

  Future<Position> determinePosition() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Permiso denegado');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<Map<String, double>> getLocation() async{
    Position position = await determinePosition();
    return {'latitude': position.latitude, 'longitude': position.longitude};
  }

  Future<void> openAplicationMap(double latitude, double longitude) async{
    final availableMaps = await MapLauncher.installedMaps;
    if(availableMaps.isNotEmpty){
      await availableMaps.first.showMarker(coords: Coords(latitude, longitude), title: 'Ubicación');
    }else{
      return Future.error('No hay aplicaciones de mapas instaladas');
    }
  }

}