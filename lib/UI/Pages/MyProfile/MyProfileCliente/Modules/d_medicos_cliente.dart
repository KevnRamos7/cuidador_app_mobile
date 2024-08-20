import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/items_profile.dart';

class DMedicosCliente{

  ItemsProfile itemsProfile = Get.put(ItemsProfile());

  Widget contenido(){
    return Expanded(
      child: Stack(
        children: [
          ListView(
            children: [
              itemsProfile.header(title: 'Datos Médicos'),
              itemsProfile.item(title: 'Tipo de Sangre', value: 'O+', isEditable: false),
              itemsProfile.item(title: 'Médico Familiar', value: 'Ignacio Zaragoza', isEditable: true),
              itemsProfile.item(title: 'Teléfono Médico Familiar', value: '4771234567', isEditable: true),
              itemsProfile.itemExpanded(title: 'Antecedentes',listado: ['Medicamento 1', 'Medicamento 2', 'Medicamento 3']),
              itemsProfile.itemExpanded(title: 'Alergias',listado: ['Alergia 1', 'Alergia 2', 'Alergia 3']),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton.small(
              onPressed: (){},
              backgroundColor: Colors.blueGrey[800],
              child: const Icon(CupertinoIcons.add, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }

}