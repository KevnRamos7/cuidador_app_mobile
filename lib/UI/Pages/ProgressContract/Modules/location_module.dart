import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationModule {

  Widget mapTest(LatLng initialCoordinates){
    return FlutterMap(
      options: MapOptions(
        initialCenter: initialCoordinates, // Coordenadas de ejemplo (San Francisco)
        initialZoom: 13,
      ),
      children: [
        MarkerLayer(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: initialCoordinates,
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 50.0,
              ),
            ),
          ],
        ),
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