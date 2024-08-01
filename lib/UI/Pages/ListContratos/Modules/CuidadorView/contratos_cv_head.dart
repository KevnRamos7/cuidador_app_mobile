import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/Shared/modal_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';

import 'contratos_cv_detalle.dart';
import 'contratos_cv_estatus.dart';

class ContratosCvHead{

  ContratosCvEstatus estatus = Get.put(ContratosCvEstatus());
  ContratosCvDetalle detalle = Get.put(ContratosCvDetalle());
  ModalComponents modalComponents = ModalComponents();

  Widget contenido(){
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index){
          return _contenidoItem(context);
        },
      )
    );
  }

  Widget _contenidoItem(BuildContext context){
    return GestureDetector(
      child: Card(
        elevation: 2,
        color: const Color.fromARGB(255, 49, 77, 91),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('08:00', style: TextStyle(color: Colors.white, fontSize: 20),),
              const Text('Juan Peréz Robledo', style: TextStyle(color: Colors.white, fontSize: 15),),
              _showPullMenu(),
            ],
          ),
        ),
      ),
    );
  }

  PullDownButton _showPullMenu(){
    return PullDownButton(
      buttonBuilder: (context, showMenu) => CupertinoButton(
        onPressed: showMenu,
        padding: const EdgeInsets.all(0),
        child: const Icon(CupertinoIcons.ellipsis, color: Colors.white, size: 15,)
      ) ,
      itemBuilder: (context) {
        return [
          PullDownMenuItem( //Interactuar con el contrato
            onTap: (){modalComponents.showModal(estatus.contenidoEstatus(true.obs));},
            title: 'Entrar',
            icon: CupertinoIcons.square_arrow_right_fill,
            iconColor: Colors.blueGrey,
          ),
          PullDownMenuItem(
            onTap: (){
              Get.toNamed('/previewProfileCliente');
            },
            title: 'Ver Perfil',
            icon: CupertinoIcons.person_alt_circle_fill,
          ),
          PullDownMenuItem(
            onTap: (){},
            title: 'Detalle',
            icon: CupertinoIcons.square_list_fill,
          ),
          PullDownMenuItem(
            onTap: (){modalComponents.showConfirmCancel(
              message: '¿Estás seguro de rechazar el contrato?',
              onConfirm: (){},
              onCancel: (){}
            );},
            title: 'Rechazar',
            icon: CupertinoIcons.xmark_circle_fill,
            iconColor: Colors.red,
            isDestructive: true,
          ),
        ];
      },
    );
  }

  

}