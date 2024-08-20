import 'package:cuidador_app_mobile/Domain/Model/Objects/lista_contratos.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/list_contrato_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContratosEstatus{

  ListContratoController controller = Get.put(ListContratoController());

  Widget contenidoEstatus(bool estatus, ListaContratos contrato){
    return contrato.estatus!.idEstatus == 18 ?
     _contenidoEstatusBasico() : 
     ( (contrato.estatus!.idEstatus == 8 || contrato.estatus!.idEstatus == 9) ? _contenidoEstatusCancelado() : _contratoEnCursoView(contrato) );
  }

  Widget _contenidoEstatusCancelado(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ 
        Image.asset('assets/img/introductions/intro_1.png', height: 200,),
        const SizedBox(height: 30),
        const Text('Contrato No Activo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
        const SizedBox(height: 20),
        const Text('El contrato no se encuentra activo.', 
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey), textAlign: TextAlign.center
        ),
        const SizedBox(height: 20),
        const Icon(CupertinoIcons.nosign, color: Colors.red, size: 50)
      ],
    ); 
  }

  Widget _contenidoEstatusBasico(){
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Image.asset('assets/img/introductions/intro_1.png', height: 200,),
            const SizedBox(height: 30),
            const Text('Contrato Pendiente', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
            const SizedBox(height: 20),
            const Text('El contrato se encuentra en espera de confirmación por parte del cuidador.', 
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey), textAlign: TextAlign.center
            ),
            const SizedBox(height: 20),
            const Icon(CupertinoIcons.clock_fill, color: Colors.grey, size: 50)
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            tooltip: 'Actualizar',
            onPressed: (){
              controller.timeLineList = controller.buildTimeline.construirLista(controller.eventos);
              controller.update();
            },
            child: const Icon(CupertinoIcons.refresh_circled_solid, color: Colors.white, size: 30),
          ),
        )
      ],
    ); 
  }

  Widget _contratoEnCursoView(ListaContratos contrato){
    return Stack(
      children: [
        Column(
          children: [
            _dotCuidador(contrato),
            const SizedBox(height: 30),
            _timeLine(contrato.estatus?.nombre ?? ''),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton.small(
            tooltip: 'Actualizar',
            onPressed: (){
              controller.timeLineList = controller.buildTimeline.construirLista(controller.eventos);
              controller.update();
            },
            child: const Icon(CupertinoIcons.refresh_circled_solid, color: Colors.white, size: 30),
          ),
        )
      ],
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
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(contrato.personaCuidador?.avatarImage ?? '', 
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Image(image: AssetImage('assets/img/shared/avatar_default.jpg'), width: 150, height: 150, fit: BoxFit.cover);
                      },
                    ),
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
                Text('${contrato.personaCuidador?.nombre ?? ''} ${contrato.personaCuidador?.apellidoPaterno ?? ''}', 
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

  Widget _timeLine(String estatus){
    return Column(
      children: [
        const Text('Seguimiento', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 90, 89, 89)), textAlign: TextAlign.start),
        Text('- $estatus -', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 90, 89, 89)), textAlign: TextAlign.start),
        const SizedBox(height: 10),
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
      ],
    );
  }

}