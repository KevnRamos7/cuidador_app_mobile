
import 'package:cuidador_app_mobile/Domain/Model/Objects/lista_contratos.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/build_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

import '../../Models/list_contrato_controller.dart';

class ContratosCvEstatus{
  ListContratoController controller = Get.put(ListContratoController());
  BuildMap buildMap = Get.put(BuildMap());

  Widget contenidoEstatus(RxBool estatus, ListaContratos contrato){
    return  Obx(()=> estatus.value ? _contenidoEstatusAceptado(contrato) : _contenidoEstatusBasico(contrato));
  }

  Widget _contenidoEstatusBasico(ListaContratos contrato){
    return Obx(()=>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img/introductions/intro_1.png', height: 200,),
          const SizedBox(height: 30),
          const Text('Contrato No Aceptado', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
          const SizedBox(height: 20),
          const Text('Aún no has aceptado el contrato, por favor revisa los detalles del mismo, si estás de acuerdo con los términos, acepta el contrato.', 
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey), textAlign: TextAlign.center
          ),
          const SizedBox(height: 20),
          const Icon(CupertinoIcons.clock_fill, color: Colors.grey, size: 50),
          const SizedBox(height: 30),
          controller.statusContratoLoading.value == true ? const CupertinoActivityIndicator() :
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton.extended(
                onPressed: (){
                  controller.cambiarEstatusContrato(contrato.idContratoItem!, 7);
                }, 
                label: const Text('Aceptar', style: TextStyle(color: Colors.white),), 
                icon: const Icon(CupertinoIcons.check_mark, color: Colors.white), 
                backgroundColor: const Color.fromARGB(255, 69, 100, 77),
                heroTag: 'aceptar',
              ),
              FloatingActionButton.extended(
                onPressed: (){
                  controller.listContratoRequest.cambiarEstatusContrato(contrato.idContratoItem!, 8);
                }, 
                label: const Text('Rechazar', style: TextStyle(color: Colors.white),), 
                icon: const Icon(CupertinoIcons.xmark, color: Colors.white), 
                backgroundColor: const Color.fromARGB(255, 219, 65, 65),
                heroTag: 'rechazar',
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _contenidoEstatusAceptado(ListaContratos contrato){
    return SizedBox(
      height: Get.height * 0.8,
      width: Get.width * 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _dotCuidador(contrato),
            SizedBox(
              height: Get.height * 0.8,
              child: PageView(
                onPageChanged: (value) async{
                  if(value == 0){
                    await buildMap.obtenerCoordenadas(
                      '${contrato.personaCliente?.domicilio?.calle ?? ''} ${contrato.personaCliente?.domicilio?.numeroExterior ?? ''} ${contrato.personaCliente?.domicilio?.colonia ?? ''} ${contrato.personaCliente?.domicilio?.ciudad ?? ''} ${contrato.personaCliente?.domicilio?.estado ?? ''}',
                    );
                  }
                },
                children: [
                  _mapaUbicacion(),
                  _timeLine(contrato.estatus?.nombre ?? '', contrato),
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
        controller.contrato.value.estatus?.idEstatus != 18 ? const SizedBox() :
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

  Widget _dotCuidador(ListaContratos contrato){
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
                  child: Image.network(
                    contrato.personaCliente?.avatarImage ?? 'assets/img/testing/profile_image_test.png',
                    errorBuilder: (context, error, stackTrace) => const Image(
                      image: AssetImage('assets/img/testing/profile_image_test.png'),
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: Get.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${contrato.personaCliente?.nombre ?? ''} ${contrato.personaCliente?.apellidoPaterno ?? ''}', 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Importe por', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w300),),
                    Text('\$ ${contrato.importeCuidado} MXN', style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),),
                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  } 

  Widget _timeLine(String estatus, ListaContratos contrato){
    return SizedBox(
      height: Get.height * 0.8,
      child: Obx(()=>
        Column(
          children: [
            const SizedBox(height: 30),
            Text(estatus, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 90, 89, 89)), textAlign: TextAlign.start),
            const SizedBox(height: 30,),
            const Text('Seguimiento', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 90, 89, 89)), textAlign: TextAlign.start),
            Expanded(
                // height: Get.height * 0.6,
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
            controller.statusTareaLoading.value == true ? const CupertinoActivityIndicator() :
            displayActions(
              contrato.estatus?.idEstatus == 7 ? 2 : (
                controller.eventos.where((element) => element.esTarea == true).length == 1 ? 3 : 1
              ),
              contrato.idContratoItem!
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget displayActions(int typeDisplay, int indiceContrato){
    Get.lazyPut(() => ListContratoController());
    ListContratoController con = Get.find();
    switch (typeDisplay) {
      case 1:
      return const SizedBox();
        // return SizedBox(
        //   height: Get.height * 0.05,
        //   width: Get.width * 0.5,
        //   child: FloatingActionButton.extended(
        //     onPressed: (){
        //       con.cambiarEstatusContrato(indiceContrato, 19);
        //     }, 
        //     label: const Text('Iniciar Contrato', style: TextStyle(color: Colors.white),), 
        //     icon: const Icon(CupertinoIcons.play_arrow, color: Colors.white), 
        //     backgroundColor: Colors.blueGrey[700]
        //   ),
        // );
      case 2:
        return const SizedBox();
        // return SizedBox(
        //   height: Get.height * 0.05,
        //   width: Get.width * 0.5,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       FloatingActionButton(
        //         onPressed: (){
        //           con.cambiarEstatusTarea(19);
        //         },
        //         backgroundColor: Colors.green,
        //         heroTag: 'aceptar',
        //         child: const Icon(CupertinoIcons.check_mark, color: Colors.white),
        //       ),
        //       FloatingActionButton(
        //         onPressed: (){
        //           con.cambiarEstatusTarea(18);
        //         },
        //         backgroundColor: Colors.orange,
        //         heroTag: 'posponer',
        //         child: const Icon(CupertinoIcons.timer_fill, color: Colors.white),
        //       ),
        //       FloatingActionButton(
        //         onPressed: (){
        //           con.cambiarEstatusTarea(8);
        //         },
        //         backgroundColor: Colors.red,
        //         heroTag: 'rechazar',
        //         child: const Icon(CupertinoIcons.xmark, color: Colors.white),
        //       ),
        //     ],
        //   ),
        // );
      case 3:
        return SizedBox(
          height: Get.height * 0.05,
          width: Get.width * 0.5,
          child: Row(
            children: [
              FloatingActionButton(
                onPressed: (){},
                backgroundColor: Colors.green,
                child: const Icon(CupertinoIcons.check_mark, color: Colors.white),
              ),
              FloatingActionButton(
                onPressed: (){},
                backgroundColor: Colors.red,
                child: const Icon(CupertinoIcons.xmark, color: Colors.white),
              ),
            ],
          ),
        );
      default:
        return SizedBox(
          height: Get.height * 0.05,
          width: Get.width * 0.5,
          child: Row(
            children: [
              FloatingActionButton.extended(
                onPressed: (){
                  con.cambiarEstatusContrato(indiceContrato, 19);
                }, 
                label: const Text('Iniciar', style: TextStyle(color: Colors.white),), 
                icon: const Icon(CupertinoIcons.play_arrow, color: Colors.white), 
                backgroundColor: Colors.blueGrey[700]
              ),
            ],
          ),
        );
    }
  }

}