import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/ClienteView/contratos_head.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/CuidadorView/contratos_cv_head.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/header_listcontrato.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Shared/BottomNavigation/bottom_navigation_main.dart';

class ListcontratoPageMain extends StatelessWidget {
  ContratosHead head = Get.put(ContratosHead());
  ContratosCvHead headCv = Get.put(ContratosCvHead());
  HeaderListcontrato header = Get.put(HeaderListcontrato());

  @override
  Widget build(BuildContext context) {
    // UsuarioModel usuario = UsuarioModel.fromJson(GetStorage().read('usuario'));
    return Scaffold(
      appBar: AppBar(
        actions: [
          // IconButton(
          //   icon: const Icon(CupertinoIcons.calendar_circle_fill, size: 35,), 
          //   onPressed: () {

          //   },
          // )
        ],
      ),
      body: Column(
        children: [
          header.encabezado(),
          header.listaFechas(),
          // usuario.salarioCuidador == 0 ? 
          // head.contenido() 
          //: 
          headCv.contenido()
        ],
      ),
      bottomNavigationBar: BottomNavigationMain.instance.bottomNavigation(),
    );
  }

}