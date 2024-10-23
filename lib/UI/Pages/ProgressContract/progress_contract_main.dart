// import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:cuidador_app_mobile/UI/Pages/ProgressContract/Models/progress_contract_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/ProgressContract/Modules/location_module.dart';
import 'package:cuidador_app_mobile/UI/Pages/ProgressContract/Modules/resume_module.dart';
import 'package:cuidador_app_mobile/UI/Pages/ProgressContract/Modules/tasks_module.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/dynamic_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';

class ProgressContractMain extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    DynamicContainer dynamicContainer = Get.put(DynamicContainer());

    Get.lazyPut(() => ProgressContractController());
    ProgressContractController controller = Get.find<ProgressContractController>();

    Get.lazyPut(() => LocationModule());
    LocationModule locationModule = Get.find<LocationModule>();

    TasksModule tasksModule = Get.put(TasksModule());
    ResumeModule resumeModule = Get.put(ResumeModule());

    return Obx(()=>
      Scaffold(
        floatingActionButton: _pullDownButtons(controller.currectStep.value == 0),
        floatingActionButtonLocation: controller.currectStep.value == 0 ? ExpandableFab.location : null,
        body: Material(
          child: Stack(
            children: [
                
              controller.currectStep.value == 0 ? 
                locationModule.mapTest() : (
              controller.currectStep.value == 1 ? 
                tasksModule.taskList() 
              : resumeModule.resume_container()
              ),
        
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: dynamicContainer.dynamicContainerBig(
                  nombre: 'Cuidador Name', 
                  ciudad: 'Nombre de la ciudad', 
                  importe: 2000, 
                  fecha: 'Lunes 12 de Julio de 2024', 
                  imagen: 'assets/img/testing/profile_image_test.png'
                  ),
                ),
              ),
        
              Align(
                alignment: Alignment.bottomCenter,
                child: _bottomNavigator()
              ),
        
            ],
          ),
        ),
      ),
    );
  }

  Widget _pullDownButtons(bool isActive){
    return !isActive ? //añadir validacion de si el contrato esta en curso
      FloatingActionButton.small(
          tooltip: 'Finalizar Contrato',
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: const Color(0xFF0D7289),
          onPressed: (){},
          child: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.white,),
        )
     : ExpandableFab(
      type: ExpandableFabType.up,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(CupertinoIcons.equal_circle_fill),
        fabSize: ExpandableFabSize.small,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        fabSize: ExpandableFabSize.small,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
      ),
      distance: 70,
      children: [
        FloatingActionButton.small(
          tooltip: 'Iniciar Viaje',
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: const Color(0xFF0D7289),
          onPressed: (){},
          child: const Icon(CupertinoIcons.play_circle_fill, color: Colors.white,),
        ),
        FloatingActionButton.small(
          tooltip: 'Cancelar Contrato',
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: const Color(0xFF891F0D),
          onPressed: (){},
          child: const Icon(CupertinoIcons.xmark_circle_fill, color: Colors.white,),
        ),
        FloatingActionButton.small(
          tooltip: 'Completar Viaje',
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: const Color(0xFF0D8936),
          onPressed: (){},
          child: const Icon(CupertinoIcons.flag_fill, color: Colors.white,),
        ),
      ],
    );
  }

  Widget _bottomNavigator(){
    ProgressContractController con = Get.find<ProgressContractController>();
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFF2F2F2F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 30,
            offset: Offset(0, 15),
            spreadRadius: 0,
          )
        ],
      ),
      margin: EdgeInsets.only(
        left: Get.height * 0.01,
        right: Get.height * 0.01,
        bottom: Get.height * 0.05,
      ),
      padding: EdgeInsets.symmetric(horizontal: Get.height * 0.02),
      height: 60,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(()=>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            
                _formatText(
                  texto: 'Ubicación',
                  onTap: (){
                    con.currectStep.value = 0;
                  },
                  isActive: con.currectStep.value == 0
                ),
            
                _formatText(
                  texto: 'Tareas',
                  onTap: (){
                    con.currectStep.value = 1;
                  },
                  isActive: con.currectStep.value == 1
                ),
            
                _formatText(
                  texto: 'Detalles',
                  onTap: (){
                    con.currectStep.value = 2;
                  },
                  isActive: con.currectStep.value == 2
                ),
            
                _formatText(
                  texto: 'Salir',
                  onTap: (){
                    Get.offNamedUntil('/feedPage', (route) => false);
                  },
                  isActive: false
                ),
            
                const SizedBox(height: 30, width: 30,)
            
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formatText({required String texto, required Function onTap, required bool isActive}){
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Center(
        child: Column(
          children: [
            Text(texto,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isActive ? Colors.white : Colors.grey
              ),
            ),
            isActive ? Container(
              width: 5,
              height: 5,
              decoration: const ShapeDecoration(
                color: Color(0xFF0D7289),
                shape: OvalBorder(),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }

}