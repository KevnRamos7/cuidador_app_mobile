
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/build_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

import '../../Models/list_contrato_controller.dart';

class ContratosCvEstatus{
  ListContratoController controller = Get.put(ListContratoController());
  BuildMap buildMap = Get.put(BuildMap());

  Widget contenidoEstatus(RxBool estatus){
    return  Obx(()=> estatus.value ? _contenidoEstatusAceptado() : _contenidoEstatusBasico());
  }

  Widget _contenidoEstatusBasico(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/img/introductions/intro_1.png', height: 200,),
        const SizedBox(height: 30),
        const Text('Contrato No Aceptado', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
        const SizedBox(height: 20),
        const Text('Aún no has aceptado el contrato, por favor revisa los detalles del mismo.', 
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey), textAlign: TextAlign.center
        ),
        const SizedBox(height: 20),
        const Icon(CupertinoIcons.clock_fill, color: Colors.grey, size: 50),
        Column(
          children: [
            FloatingActionButton.small(onPressed: (){}, tooltip: 'Aceptar',
              child: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.green, size: 30),
            ),
            FloatingActionButton.small(onPressed: (){}, tooltip: 'Rechazar',
              child: const Icon(CupertinoIcons.xmark_circle_fill, color: Colors.red, size: 30),
            ),
            FloatingActionButton.small(onPressed: (){}, tooltip: 'Refrescar',
              child: const Icon(CupertinoIcons.refresh_circled_solid, color: Colors.blueGrey, size: 30),
            ),
          ],
        )
      ],
    );
  }

  Widget _contenidoEstatusAceptado(){
    return SizedBox(
      height: Get.height * 0.8,
      width: Get.width * 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _dotCuidador(),
            SizedBox(
              height: Get.height * 0.8,
              child: PageView(
                onPageChanged: (value) async{
                  if(value == 0){
                    await buildMap.obtenerCoordenadas('La luz 223, El Coecillo, León, Guanajuato');
                  }
                },
                children: [
                  _mapaUbicacion(),
                  _timeLine()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mapaUbicacion(){
    return Column(
      children: [
        const SizedBox(height: 30),
        const Text('Ubicación', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 90, 89, 89)), textAlign: TextAlign.start),
        Container(
          margin: const EdgeInsets.all(16),
          height: Get.height * 0.5,
          width: Get.width * 0.8,
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 1,
              )
            ],
          ),
          child: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter: buildMap.coordenadasCuidador, // Coordenadas de ejemplo (San Francisco)
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
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: buildMap.coordenadasCuidador,
                        child: Container(
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset(
                            'assets/img/testing/profile_image_test.png',
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Marker(
                        point: buildMap.coordenadasCliente,
                        child: Container(
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset(
                            'assets/img/testing/profile_image_test.png',
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [buildMap.coordenadasCuidador, buildMap.coordenadasCliente],
                        strokeWidth: 2,
                        color: Colors.blueGrey,
                      ),
                    ],
                  )
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: FloatingActionButton(
                  tooltip: 'Ver en mapa',
                  onPressed: () async{
                    await buildMap.googleMapsUtilities.openAplicationMap(buildMap.coordenadasCliente.latitude, buildMap.coordenadasCliente.longitude);
                  },
                  backgroundColor: const Color(0xFF1E6892),
                  child: const Icon(CupertinoIcons.location, color: Colors.white),
                ),
              ),
            ],
          )
        ),
        const Text('Desliza para ver el seguimiento del servicio', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey), textAlign: TextAlign.center),
        const SizedBox(height: 30),
        _formatoBotonCambioEstatus('Iniciar', Colors.blueGrey[700]!, (){}),
        const SizedBox(height: 30),
      ],
    );
  } 

  Widget _formatoBotonCambioEstatus(String texto, Color color, Function() evento){
    return SizedBox(
      height: Get.height * 0.05,
      width: Get.width * 0.5,
      child: ElevatedButton(
        onPressed: evento,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(texto, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),),
      ),
    );
  }

  Widget _dotCuidador(){
    return Container(
      height: Get.height * 0.08,
      width: Get.width * 0.9,
      decoration: ShapeDecoration(
        color: const Color(0xFF1E6892),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [

          SizedBox(
            width: Get.width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(
                    'assets/img/testing/profile_image_test.png',
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: Get.width * 0.6,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Juan Pérez Robledo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Importe por', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w300),),
                    Text('\$ 3000.00 MXN', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),),
                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  } 

  Widget _timeLine(){
    return Column(
      children: [
        const SizedBox(height: 30),
        const Text('Seguimiento', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 90, 89, 89)), textAlign: TextAlign.start),
        SizedBox(
          height: Get.height * 0.6,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return controller.timeLineList[index];
                }, 
                childCount: controller.timeLineList.length
              ),
              )
            ],
          ),
        ),
        const SizedBox(height: 30),
        _formatoBotonCambioEstatus('Completar', Colors.blueGrey[700]!, (){}),
        const SizedBox(height: 30),
      ],
    );
  }
}