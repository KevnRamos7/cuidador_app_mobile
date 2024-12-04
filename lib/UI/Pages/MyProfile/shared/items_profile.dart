import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Models/my_profile_cliente_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class ItemsProfile{

  Widget header({required String title}){
    Get.lazyPut<MyProfileClienteController>(() => MyProfileClienteController());
    MyProfileClienteController con = Get.find<MyProfileClienteController>();
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(CupertinoIcons.back, size: 30, color: Colors.grey[700]), onPressed: () => con.changeIndex(0),),
          Text(title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey[700]),),
        ],
      ),
    );
  }

  Widget item({required String title, required String value, required bool isEditable, Function(String)? onChanged}){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      child: TextFormField(
        initialValue: value,
        onChanged: onChanged != null ? (value) => onChanged(value) : null,
        readOnly: !isEditable,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          suffixIcon: isEditable ? const Icon(CupertinoIcons.pencil_circle_fill, size: 20, color: Colors.black54,) : null,
        ),
      ),
    );
  }

  Widget itemExpanded({required String title, required List<String> listado, Function(String)? onSave}) {
    TextEditingController controller = TextEditingController();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ExpansionTile(
        title: Text(title, style: TextStyle(color: Colors.grey[600])),
        children: [
          ...listado.map((e) {
            controller.text = e;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: TextFormField(
                controller: controller,
                readOnly: false,
                decoration: InputDecoration(
                  labelText: e,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  suffixIcon: const Icon(CupertinoIcons.pencil_circle_fill, size: 20, color: Colors.black54),
                ),
                onChanged: (value) {
                  int index = listado.indexOf(e);
                  listado[index] = value;
                  onSave!(listado.join(','));
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget subtitleAndItemsNoEditable({
    required String nombrePadecimiento,
    required String fechaPadecimiento,
    Function(Tuple2<String, String>)? onSave,
  }) {
    final nombreController = TextEditingController(text: nombrePadecimiento);
    final fechaController = TextEditingController(text: fechaPadecimiento);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1.0),
        ),
      ),
      child: ExpansionTile(
        title: Text(
          nombreController.text,
          style: TextStyle(color: Colors.grey[600]),
        ),
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: TextFormField(
                  controller: nombreController,
                  readOnly: false,
                  onChanged: (value) {
                    if (onSave != null) {
                      onSave(Tuple2(value, fechaController.text));
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Nombre del Padecimiento',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: const Icon(
                      CupertinoIcons.pencil_circle_fill,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
                Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 200,
                child: GestureDetector(
                  onTap: () async {
                  DateTime? pickedDate = await showCupertinoModalPopup<DateTime>(
                    context: Get.context!,
                    builder: (context) {
                    return Container(
                      height: 250,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: Column(
                      children: [
                        SizedBox(
                        height: Get.height * 0.2,
                        child: CupertinoDatePicker(
                          initialDateTime: DateTime.tryParse(fechaController.text) ?? DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime dateTime) {
                          fechaController.text = dateTime.toIso8601String().split('T').first;
                          if (onSave != null) {
                            onSave(Tuple2(nombreController.text, fechaController.text));
                          }
                          },
                        ),
                        ),
                        CupertinoButton(
                        child: const Text('Aceptar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        )
                      ],
                      ),
                    );
                    },
                  );
                  },
                  child: AbsorbPointer(
                  child: TextFormField(
                    controller: fechaController,
                    readOnly: true,
                    decoration: InputDecoration(
                    labelText: 'Fecha de Diagnóstico',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: const Icon(
                      CupertinoIcons.calendar,
                      size: 20,
                      color: Colors.black54,
                    ),
                    ),
                  ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}