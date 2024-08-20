import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/items_profile.dart';

class DomicilioCliente{

  ItemsProfile itemsProfile = Get.put(ItemsProfile());

  Widget contenido(){
    return Expanded(
      child: ListView(
        children: [
          itemsProfile.header(title: 'Domicilio'),
          itemsProfile.item(title: 'Calle', value: 'Brisa del Sol', isEditable: true),
          itemsProfile.item(title: 'Colonia', value: 'Brisas del Pedregal', isEditable: true),
          itemsProfile.item(title: 'Número Exterior', value: '126a', isEditable: true),
          itemsProfile.item(title: 'Número Interior', value: '', isEditable: true),
          itemsProfile.item(title: 'Ciudad', value: 'León', isEditable: true),
          itemsProfile.item(title: 'Estado', value: 'Guanajuato', isEditable: true),
          itemsProfile.item(title: 'País', value: 'México', isEditable: true),
          itemsProfile.item(title: 'Referencias', value: 'Casa en la esquina', isEditable: true),
        ],
      ),
    );
  }

}