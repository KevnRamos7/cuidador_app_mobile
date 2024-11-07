import 'package:cuidador_app_mobile/Domain/Model/Objects/estatus_contrato_item_cliente.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/list_contrato_controller.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/dynamic_container.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/screens_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EstatusContratoCliente extends StatelessWidget {
  const EstatusContratoCliente({super.key});

  @override
  Widget build(BuildContext context) {
    DynamicContainer dynamicContainer = Get.put(DynamicContainer());
    Get.lazyPut(() => ListContratoController());
    ListContratoController controller = Get.find();
    LetterDates letter = LetterDates();
    ScreenStates screenStates = Get.put(ScreenStates());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Material(
          child: controller.statusEstatusContratoLoading.value == true ? screenStates.loadingScreen() : 
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dynamicContainer.dynamicContainerBig(
                    nombre: 'Costo Total: ${controller.estatusContrato.value.importeTotal}', 
                    ciudad: 'Horas contratadas: ${controller.estatusContrato.value.tiempoContratado! / 60}', 
                    importe: (controller.estatusContrato.value.importeTotal! / (controller.estatusContrato.value.tiempoContratado! / 60)), 
                    fecha: letter.formatearSoloFecha(controller.estatusContrato.value.horarioInicioPropuesto!.toString()), 
                    imagen: 'assets/img/introductions/isotipo.png'
                    ),
                ],
              ),

              SizedBox(height: Get.height * 0.05),

              const Text('Contrato', style: TextStyle(color: Color(0xFF6F6F6F), fontSize: 20, fontWeight: FontWeight.bold),),

              Expanded(
                child: ListView(
                  children: [
                    _itemListContract('Fecha Propuesta', controller.estatusContrato.value.horarioInicioPropuesto.toString()),
                    _itemListContract('Fecha Aceptación', controller.estatusContrato.value.fechaAceptacion.toString()),
                    _itemListContract('Fecha Inicio', controller.estatusContrato.value.fechaInicioCuidado.toString()),
                    _itemListContract('Fecha Fin', controller.estatusContrato.value.fechaFinCuidado.toString()),
                  ],
                ),
              ),

              const Text('Tareas', style: TextStyle(color: Color(0xFF6F6F6F), fontSize: 20, fontWeight: FontWeight.bold),),

              Expanded(
                child: ListView.builder(
                  itemCount: controller.estatusContrato.value.estatusTareas!.length,
                  itemBuilder: (BuildContext context, int index){
                    return _itemList(controller.estatusContrato.value.estatusTareas![index]);
                  },
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Get.back();
              //     },
              //     child: const Text('Back'),
              //   ),
              // )
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemListContract(String title, String subtitle){
    DateTime defaultDate = DateTime(0001, 01, 01, 00, 00, 00);
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0x4CF1F9FD),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFF6F6F6F)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ExpansionTile(
        shape: ShapeBorder.lerp(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), 0.5),
        trailing: Icon(DateTime.tryParse(subtitle)!.isAtSameMomentAs(defaultDate) ? Icons.cancel : Icons.check, color: DateTime.tryParse(subtitle)!.isAtSameMomentAs(defaultDate) ? Colors.red : Colors.green,),
        title: Text(title, style: const TextStyle(color: Color(0xFF6F6F6F), fontSize: 13, fontWeight: FontWeight.bold),),
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey, height: 0.5,),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height:50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(subtitle, style: const TextStyle(color: Color(0xFF6F6F6F), fontSize: 13, fontWeight: FontWeight.w400),),
              ],
            )),
        ],
      ),
    );
  }

  Widget _itemList(EstatusTarea estatusTarea){
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0x4CF1F9FD),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFF6F6F6F)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ExpansionTile(
        shape: ShapeBorder.lerp(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), 0.5),
        trailing: Text(estatusTarea.nombreEstatus ?? '', style: const TextStyle(color: Color(0xFF6F6F6F), fontSize: 13, fontWeight: FontWeight.bold),),
        title: Text(estatusTarea.tituloTarea ?? '', style: const TextStyle(color: Color(0xFF6F6F6F), fontSize: 13, fontWeight: FontWeight.bold),),
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey, height: 0.5,),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height:50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(estatusTarea.descripcionTarea ?? '', style: const TextStyle(color: Color(0xFF6F6F6F), fontSize: 13, fontWeight: FontWeight.w400),),
                Text(estatusTarea.fechaEstatusTarea.toString(), style: const TextStyle(color: Color(0xFF6F6F6F), fontSize: 13, fontWeight: FontWeight.w400),),
              ],
            )),
        ],
      ),
    );
  }

}