// ignore_for_file: collection_methods_unrelated_type

import 'package:cuidador_app_mobile/Domain/Utilities/google_maps_utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BuildMap{

  GoogleMapsUtilities googleMapsUtilities = GoogleMapsUtilities();

  late GoogleMapController mapController;

  LatLng coordinadasCuidador = const LatLng(0.0, 0.0);
  LatLng coordinadasCliente = const LatLng(0.0, 0.0);

  CameraUpdate cameraUpdate = CameraUpdate.newLatLng(const LatLng(0.0, 0.0));
  LatLngBounds bounds = LatLngBounds(southwest: const LatLng(0.0, 0.0), northeast: const LatLng(0.0, 0.0));
  Set<Marker> markers = <Marker>{};


  void obtenerCoordenadas(String direccionCuidador, String direccionCliente) async {
    Map<String, double> coordenadasCuidador = await googleMapsUtilities.convertAddressToCoordinates(direccionCuidador);
    Map<String, double> coordenadasCliente = await googleMapsUtilities.convertAddressToCoordinates(direccionCliente);

    coordinadasCuidador = LatLng(coordenadasCuidador['latitude']!, coordenadasCuidador['longitude']!);
    coordinadasCliente = LatLng(coordenadasCliente['latitude']!, coordenadasCliente['longitude']!);
  }

  void crearMapa(BuildContext context){

    //Son los puntos del mapa
    markers.add(Marker(markerId: const MarkerId('cuidador'), position: coordinadasCuidador));
    markers.add(Marker(markerId: const MarkerId('cliente'), position: coordinadasCliente));

    //Enfocar los marcadores
    bounds = LatLngBounds(
      southwest: LatLng(coordinadasCuidador.latitude, coordinadasCuidador.longitude),
      northeast: LatLng(coordinadasCliente.latitude, coordinadasCliente.longitude)
    );

    cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);

  }

}