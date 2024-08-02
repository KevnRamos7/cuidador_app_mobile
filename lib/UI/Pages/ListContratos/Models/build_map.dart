// ignore_for_file: collection_methods_unrelated_type

// import 'dart:async';

// import 'package:cuidador_app_mobile/Domain/Utilities/google_maps_utilities.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:cuidador_app_mobile/Domain/Utilities/maps_utilities.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class BuildMap extends GetxController{

  MapsUtilities googleMapsUtilities = Get.put(MapsUtilities());

  LatLng coordenadasCuidador = const LatLng(0.0, 0.0);
  LatLng coordenadasCliente = const LatLng(0.0, 0.0);



  Future<void> obtenerCoordenadas(String direccionCliente) async {
    await googleMapsUtilities.determinePosition();
    Map<String, double> coordsCuidador = await googleMapsUtilities.getLocation();
    Map<String, double> coordsCliente = await googleMapsUtilities.convertAddressToCoordinates(direccionCliente);

    // Asignar las coordenadas obtenidas a las variables LatLng
    coordenadasCuidador = LatLng(coordsCuidador['latitude']!, coordsCuidador['longitude']!);
    coordenadasCliente = LatLng(coordsCliente['latitude']!, coordsCliente['longitude']!);
  }


  @override
  void onInit() async{
    super.onInit();
    await obtenerCoordenadas('La luz 223, El Coecillo, León, Guanajuato');
  }

}