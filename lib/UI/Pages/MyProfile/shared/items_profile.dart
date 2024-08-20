import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Models/my_profile_cliente_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Modules/padecimientos_cliente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  Widget item({required String title, required String value, required bool isEditable}){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      child: TextFormField(
        initialValue: value,
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

  Widget itemExpanded({required String title, required List<String> listado}){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 10),
      child: ExpansionTile(
        title: Text(title, style: TextStyle(color: Colors.grey[600]),),
        children: listado.map((e) => Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: TextFormField(
            initialValue: e,
            readOnly: false,
            decoration: InputDecoration(
              labelText: e,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              suffixIcon: const Icon(CupertinoIcons.pencil_circle_fill, size: 20, color: Colors.black54,),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget subtitleAndItemsNoEditable({required String nombrePadecimiento, required String fechaPadecimiento}){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1.0),
        ),
      ),
      child: ExpansionTile(
        title: Text(nombrePadecimiento, style: TextStyle(color: Colors.grey[600]),),
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: TextFormField(
                  initialValue: nombrePadecimiento,
                  readOnly: false,
                  decoration: InputDecoration(
                    labelText: 'Nombre del Padecimiento',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: const Icon(CupertinoIcons.pencil_circle_fill, size: 20, color: Colors.black54,)
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: TextFormField(
                  initialValue: fechaPadecimiento,
                  readOnly: false,
                  decoration: InputDecoration(
                    labelText: 'Fecha de Diagnóstico',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: const Icon(CupertinoIcons.pencil_circle_fill, size: 20, color: Colors.black54,)
                  ),
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }

}