import 'package:cuidador_app_mobile/Domain/Model/Catalogos/padecimientos_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Models/my_profile_cliente_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/shared/items_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PadecimientosCliente{

  ItemsProfile itemsProfile = Get.put(ItemsProfile());

  Widget contenido(){
    return Expanded(
      child: Stack(
        children: [
          Column(
            children: [
              itemsProfile.header(title: 'Padecimientos'),
                GetBuilder<MyProfileClienteController>(
                id: 'padecimientos',
                builder: (_) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: _.currentUser.value.persona?.first.datosMedicos?.padecimientos?.length ?? 0,
                      itemBuilder: (context, index){
                      return Row(
                        children: [
                        IconButton(onPressed: (){
                          _.deletePadecimiento(_.currentUser.value.persona?.first.datosMedicos?.padecimientos?[index].idPadecimiento ?? 0);
                        }, icon: const Icon(CupertinoIcons.delete, size: 20,), color: Colors.red,),
                        Expanded(
                          child: itemsProfile.subtitleAndItemsNoEditable(
                          nombrePadecimiento: _.currentUser.value.persona?.first.datosMedicos?.padecimientos?[index].nombre ?? '', 
                          fechaPadecimiento: _.currentUser.value.persona?.first.datosMedicos?.padecimientos?[index].padeceDesde ?? '', 
                          onSave: (p0) {
                            _.currentUser.value.persona?.first.datosMedicos?.padecimientos?[index].nombre = p0.item1;
                            _.currentUser.value.persona?.first.datosMedicos?.padecimientos?[index].padeceDesde = p0.item2;
                            _.currentUser.update((user) {
                            user?.persona?.first.datosMedicos?.padecimientos = _.currentUser.value.persona?.first.datosMedicos?.padecimientos;
                            });
                          },
                          ),
                        ),
                        ],
                      );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton.small(
              onPressed: () {
                showModalNewPadecimiento();
              },
              child: const Icon(Icons.add, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showModalNewPadecimiento(){
    MyProfileClienteController con = Get.find<MyProfileClienteController>();
    TextEditingController nombreController = TextEditingController();
    TextEditingController fechaController = TextEditingController();
    return Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        height: Get.height * 0.45,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text('Nuevo padecimiento', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 80, 80, 80)),),

            SizedBox(height: Get.height * 0.05),

            CupertinoTextField(
              placeholder: 'Nombre del padecimiento',
              controller: nombreController,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[200]!, width: 1.0),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () async {
              DateTime? pickedDate = await showCupertinoModalPopup<DateTime>(
                context: Get.context!,
                builder: (context) {
                return Container(
                  height: 250,
                  color: Colors.white,
                  child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  maximumDate: DateTime.now(),
                  initialDateTime: DateTime.now().subtract(const Duration(days: 1)),
                  onDateTimeChanged: (DateTime dateTime) {
                    fechaController.text = dateTime.toLocal().toString().split(' ')[0];
                  },
                  ),
                );
                },
              );
              },
              child: AbsorbPointer(
              child: CupertinoTextField(
                controller: fechaController,
                placeholder: 'Fecha en que padece',
                decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[200]!, width: 1.0),
                ),
                ),
              ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async{
                await con.addPadecimiento(PadecimientosModel(
                  nombre: nombreController.text,
                  padeceDesde: fechaController.text,
                ));
              },
              child: const Text('Guardar', style: TextStyle(color: Colors.white),),
            ),

          ],
        ),
      )
    );
  }

}