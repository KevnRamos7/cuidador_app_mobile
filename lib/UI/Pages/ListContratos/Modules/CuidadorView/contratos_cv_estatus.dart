import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/build_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Models/list_contrato_controller.dart';

class ContratosCvEstatus{
  ListContratoController controller = Get.put(ListContratoController());
  BuildMap buildMap = BuildMap();

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
            const SizedBox(height: 30),
            Expanded(
              child: PageView(
                children: [
                  _mapaUbicacion(),
                  _timeLine()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _mapaUbicacion(){
    return Container(
      height: Get.height * 0.4,
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: buildMap.bounds.northeast, zoom: 15),
        markers: buildMap.markers,
        onMapCreated: (GoogleMapController controller){
          buildMap.mapController = controller;
          Future.delayed(const Duration(milliseconds: 200)).then((value) => controller.animateCamera(buildMap.cameraUpdate));
        },
      ),
    );
  } 

  Widget _formatoBotonCambioEstatus(String texto, Color color, Function() evento){
    return SizedBox(
      height: Get.height * 0.07,
      width: Get.width * 0.6,
      child: ElevatedButton(
        onPressed: evento,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Text(texto, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
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
    return SizedBox(
      height: Get.height * 0.7,
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
    );
  }
}