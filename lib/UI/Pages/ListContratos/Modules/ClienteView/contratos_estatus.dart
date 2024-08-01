import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/list_contrato_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContratosEstatus{

  ListContratoController controller = Get.put(ListContratoController());

  Widget contenidoEstatus(){
    return _contratoEnCursoView();
  }

  Widget _contenidoEstatusBasico(){
    return Column(
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
        const Icon(CupertinoIcons.clock_fill, color: Colors.grey, size: 50),
        FloatingActionButton.small(onPressed: (){},
          child: const Icon(CupertinoIcons.refresh_circled_solid, color: Colors.blueGrey, size: 30),
        )
      ],
    );
  }

  Widget _contratoEnCursoView(){
    return Stack(
      children: [
        Column(
          children: [
            _dotCuidador(),
            const SizedBox(height: 30),
            _timeLine(),
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