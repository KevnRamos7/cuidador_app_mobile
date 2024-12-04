import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Models/my_profile_cliente_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/shared/items_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DPersonalesCliente{

  ItemsProfile itemsProfile = Get.put(ItemsProfile());
  Widget contenido(){
    return Expanded(
      child: 
        GetBuilder<MyProfileClienteController>(
          id: 'dataPersonal',
          builder: (_) {
        return ListView(
              children: [
                itemsProfile.header(title: 'Datos Personales'),
                itemsProfile.item(title: 'Correo Electronico', value: _.currentUser.value.persona?.first.correoElectronico ?? 's/ correo electronico', isEditable: false),
                itemsProfile.item(title: 'Fecha de Nacimiento', value: _.currentUser.value.persona?.first.fechaNacimiento ?? '', isEditable: false),
                itemsProfile.item(title: 'Genero', value: _.currentUser.value.persona?.first.genero ?? '', isEditable: false),
                itemsProfile.item(title: 'Estado Civil', value: _.currentUser.value.persona?.first.estadoCivil ?? '', isEditable: false),
                itemsProfile.item(title: 'RFC', value: _.currentUser.value.persona?.first.rfc ?? '', isEditable: false),
                itemsProfile.item(title: 'CURP', value: _.currentUser.value.persona?.first.curp ?? '', isEditable: false),
                itemsProfile.item(title: 'Telefono Particular', value: _.currentUser.value.persona?.first.telefonoParticular ?? '', isEditable: true, onChanged: (value) => _.currentUser.value.persona?.first.telefonoParticular = value),
                itemsProfile.item(title: 'Telefono Movil', value: _.currentUser.value.persona?.first.telefonoMovil ?? '', isEditable: true, onChanged: (value) => _.currentUser.value.persona?.first.telefonoMovil = value),
                itemsProfile.item(title: 'Telefono Emergencia', value: _.currentUser.value.persona?.first.telefonoEmergencia ?? '', isEditable: true, onChanged: (value) => _.currentUser.value.persona?.first.telefonoEmergencia = value),
                itemsProfile.item(title: 'Familiar Asignado', value: _.currentUser.value.persona?.first.nombreCompletoFamiliar ?? '', isEditable: true, onChanged: (value) => _.currentUser.value.persona?.first.nombreCompletoFamiliar = value),
              ],
            );
          },
        ),
    );
  }
}