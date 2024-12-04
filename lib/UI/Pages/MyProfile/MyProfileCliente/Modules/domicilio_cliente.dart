import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Models/my_profile_cliente_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/items_profile.dart';

class DomicilioCliente{

  ItemsProfile itemsProfile = Get.put(ItemsProfile());

  Widget contenido(){
    return Expanded(
      child: GetBuilder<MyProfileClienteController>(
        id: 'domicilio',
        builder: (_) {
          return ListView(
            children: [
              itemsProfile.header(title: 'Domicilio'),
              itemsProfile.item(title: 'Calle', value: _.currentUser.value.persona?.first.domicilio?.calle ?? '', isEditable: true, onChanged: (value) {
                _.currentUser.value.persona?.first.domicilio?.calle = value;
                _.currentUser.update((user) {
              user?.persona?.first.domicilio?.calle = value;
                });
              }),
              itemsProfile.item(title: 'Colonia', value: _.currentUser.value.persona?.first.domicilio?.colonia ?? '', isEditable: true, onChanged: (value) {
                _.currentUser.value.persona?.first.domicilio?.colonia = value;
                _.currentUser.update((user) {
              user?.persona?.first.domicilio?.colonia = value;
                });
              }),
              itemsProfile.item(title: 'Número Exterior', value: _.currentUser.value.persona?.first.domicilio?.numeroExterior ?? '', isEditable: true, onChanged: (value) {
                _.currentUser.value.persona?.first.domicilio?.numeroExterior = value;
                _.currentUser.update((user) {
              user?.persona?.first.domicilio?.numeroExterior = value;
                });
              }),
              itemsProfile.item(title: 'Número Interior', value: _.currentUser.value.persona?.first.domicilio?.numeroInterior ?? '', isEditable: true, onChanged: (value) {
                _.currentUser.value.persona?.first.domicilio?.numeroInterior = value;
                _.currentUser.update((user) {
              user?.persona?.first.domicilio?.numeroInterior = value;
                });
              }),
              itemsProfile.item(title: 'Ciudad', value: _.currentUser.value.persona?.first.domicilio?.ciudad ?? '', isEditable: true, onChanged: (value) {
                _.currentUser.value.persona?.first.domicilio?.ciudad = value;
                _.currentUser.update((user) {
              user?.persona?.first.domicilio?.ciudad = value;
                });
              }),
              itemsProfile.item(title: 'Estado', value: _.currentUser.value.persona?.first.domicilio?.estado ?? '', isEditable: true, onChanged: (value) {
                _.currentUser.value.persona?.first.domicilio?.estado = value;
                _.currentUser.update((user) {
              user?.persona?.first.domicilio?.estado = value;
                });
              }),
              itemsProfile.item(title: 'País', value: _.currentUser.value.persona?.first.domicilio?.pais ?? '', isEditable: true, onChanged: (value) {
                _.currentUser.value.persona?.first.domicilio?.pais = value;
                _.currentUser.update((user) {
              user?.persona?.first.domicilio?.pais = value;
                });
              }),
              itemsProfile.item(title: 'Referencias', value: _.currentUser.value.persona?.first.domicilio?.referencias ?? '', isEditable: true, onChanged: (value) {
                _.currentUser.value.persona?.first.domicilio?.referencias = value;
                _.currentUser.update((user) {
              user?.persona?.first.domicilio?.referencias = value;
                });
              }),
            ],
          );
        },
      ),
    );
  }

}