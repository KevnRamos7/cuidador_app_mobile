import 'package:cuidador_app_mobile/Domain/Model/Contrato/tareas_contrato_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/ProgressContract/Models/progress_contract_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksModule {

  

  Widget taskList(){
    Get.lazyPut(() => ProgressContractController());
    ProgressContractController controller = Get.find<ProgressContractController>();
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: Get.height * 0.2, left: 10, right: 10),
        height: Get.height * 0.73,
        width: Get.width,
        child: ListView.builder(
          itemCount: controller.contrato.value.contratoItem?[0].tareasContrato?.where((e) => e.estatus != 9).length ?? 0,
          itemBuilder: (context, index){
            TareasContratoModel tarea = controller.contrato.value.contratoItem?[0].tareasContrato![index] ?? TareasContratoModel();
            return _itemList(
              title: tarea.tituloTarea ?? '',
              time: '${tarea.fechaRealizar!.hour}:${tarea.fechaRealizar!.minute} ${tarea.fechaRealizar!.hour > 12 ? 'PM' : 'AM'}',
              description: tarea.descripcionTarea ?? '',
              idTask: index
            );
          },
        ),
      ),
    );
  }

  Widget _itemList({
    String title = 'Nombre Tarea',
    String time = '18:00 PM',
    String description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In et sem aliquet, tristique elit id, rutrum sapien. Nunc fermentum tellus eget volutpat blandit. ',
    int idTask = 0
  }){
    Get.lazyPut(() => ProgressContractController());
    ProgressContractController controller = Get.find<ProgressContractController>();
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: Get.width * 0.9,
      height: Get.height * 0.2,
      decoration: ShapeDecoration(
        color: const Color(0xFF484848),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 20,
            offset: Offset(0, 10),
            spreadRadius: 0,
          )
        ],
      ),
      child: SizedBox(
        width: Get.width * 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              
                  SizedBox(
                    height: Get.height * 0.16,
                    width: Get.width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(time,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.7,
                              child: Text(description ,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
              
                ],
              ),
            ),
            Obx(()=>
              controller.contrato.value.contratoItem![0].tareasContrato![idTask].estatus == 19
               ? FloatingActionButton.small(
                  tooltip: 'Finalizar Tarea',
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: const Color.fromARGB(255, 19, 137, 13),
                  onPressed: (){
                    controller.taskAction('finish', idTask);
                  },
                  child: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.white,),
                )
               : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.small(
                      tooltip: 'Cancelar Tarea',
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: const Color(0xFF891F0D),
                      onPressed: (){
                        controller.taskAction('cancel', idTask);
                      },
                      child: const Icon(CupertinoIcons.xmark_circle_fill, color: Colors.white,),
                    ),
                    const SizedBox(width: 10),
                     FloatingActionButton.small(
                       tooltip: 'Posponer Tarea',
                       elevation: 20,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(50),
                       ),
                       backgroundColor: const Color.fromARGB(255, 133, 137, 13),
                       onPressed: (){
                          controller.taskAction('postpone', idTask);
                       },
                       child: const Icon(CupertinoIcons.pause_circle_fill, color: Colors.white,),
                     ),
                     const SizedBox(width: 10),
                     FloatingActionButton.small(
                       tooltip: 'Iniciar Viaje',
                       elevation: 20,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(50),
                       ),
                       backgroundColor: const Color(0xFF0D7289),
                       onPressed: (){
                          controller.taskAction('start', idTask);
                       },
                       child: const Icon(CupertinoIcons.play_circle_fill, color: Colors.white,),
                     ),
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }

}