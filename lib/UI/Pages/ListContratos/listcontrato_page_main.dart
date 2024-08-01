import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/CuidadorView/contratos_head.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/header_listcontrato.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Shared/BottomNavigation/bottom_navigation_main.dart';

class ListcontratoPageMain extends StatelessWidget {
  ContratosHead head = Get.put(ContratosHead());
  HeaderListcontrato header = Get.put(HeaderListcontrato());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.calendar_circle_fill, size: 35,), 
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          header.encabezado(),
          header.listaFechas(),
          head.contenido()
        ],
      ),
      bottomNavigationBar: BottomNavigationMain.instance.bottomNavigation(),
    );
  }

  

}