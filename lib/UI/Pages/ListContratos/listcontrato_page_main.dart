import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/list_contrato_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/ClienteView/contratos_head.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/CuidadorView/contratos_cv_head.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/header_listcontrato.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/screens_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Shared/BottomNavigation/bottom_navigation_main.dart';

class ListcontratoPageMain extends StatelessWidget {
  ContratosHead head = Get.put(ContratosHead());
  ContratosCvHead headCv = Get.put(ContratosCvHead());
  HeaderListcontrato header = Get.put(HeaderListcontrato());
  ScreenStates screenStates = Get.put(ScreenStates());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ListContratoController>(() => ListContratoController());
    ListContratoController con = Get.find();
    return _stateManagement(con);
  }

  Widget _stateManagement(ListContratoController con){
    return Obx(()=>
      con.statusLoading.value == true ? screenStates.loadingScreen() : _stateMain(con)
    );
  }

  Widget _stateMain(ListContratoController con){
    dynamic usuario = GetStorage().read('usuario');
    return RefreshIndicator(
      onRefresh: () async{
        await con.getContratosPorCliente();
        con.timeLineList = con.buildTimeline.construirLista(con.eventos);
      },
      child: Scaffold(
        appBar: AppBar(
          actions: const [],
        ),
        body: Obx(()=>
          con.statusLoading.value == true ? const Center(child: CupertinoActivityIndicator()) : Column(
            children: [
              header.encabezado(),
              header.listaFechas(),
              usuario['tipoUsuarioid'] == 2 ? head.contenido() : headCv.contenido()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationMain.instance.bottomNavigation(),
      ),
    );
  }

}