import 'package:cuidador_app_mobile/UI/Pages/MyProfile/shared/items_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DPersonalesCliente{

  ItemsProfile itemsProfile = Get.put(ItemsProfile());

  Widget contenido(){
    return Expanded(
      child: ListView(
        children: [
          itemsProfile.header(title: 'Datos Personales'),
          itemsProfile.item(title: 'Correo Electronico', value: 'kevinram00047@gmail.com', isEditable: false),
          itemsProfile.item(title: 'Fecha de Nacimiento', value: 'Lunes 5 de Mayo de 2002', isEditable: false),
          itemsProfile.item(title: 'Genero', value: 'Masculino', isEditable: false),
          itemsProfile.item(title: 'Estado Civil', value: 'Soltero', isEditable: false),
          itemsProfile.item(title: 'RFC', value: 'JDFH928372', isEditable: false),
          itemsProfile.item(title: 'CURP', value: 'JDUF837483MMHDGTEVD', isEditable: false),
          itemsProfile.item(title: 'Telefono Particular', value: '4776726374', isEditable: true),
          itemsProfile.item(title: 'Telefono Movil', value: '4776726374', isEditable: true),
          itemsProfile.item(title: 'Telefono Emergencia', value: '4776726374', isEditable: true),
          itemsProfile.item(title: 'Familiar Asignado', value: '4776726374', isEditable: true),
        ],
      ),
    );
  }

  

}