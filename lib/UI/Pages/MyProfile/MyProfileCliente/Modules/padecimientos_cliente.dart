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
          ListView(
            children: [
              itemsProfile.header(title: 'Padecimientos'),
              itemsProfile.subtitleAndItemsNoEditable(nombrePadecimiento: 'Diabetes Mellitus', fechaPadecimiento: '12/12/2020'),
              itemsProfile.subtitleAndItemsNoEditable(nombrePadecimiento: 'Asma', fechaPadecimiento: '12/12/2020'),
              itemsProfile.subtitleAndItemsNoEditable(nombrePadecimiento: 'Hipertensión', fechaPadecimiento: '12/12/2020'),
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