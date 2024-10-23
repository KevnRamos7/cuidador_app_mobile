import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationModule {

  Widget mapTest(){
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(37.7749, -122.4194), // Coordenadas de ejemplo (San Francisco)
        initialZoom: 13,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
          additionalOptions:  const{
            'accessToken':'pk.eyJ1Ijoia2V2bnJhbW9zNyIsImEiOiJjbHpjMnE1b3YwNzllMmlwdzZsMWhtdDJzIn0.vlk3ITyC7M374VPtt4DYtg',
            'id':'mapbox/streets-v11',
          },
        ),
      ],
    );
  }

}