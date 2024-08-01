
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/CuidadorView/contratos_detalle.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/CuidadorView/contratos_estatus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_down_button/pull_down_button.dart';

class ContratosHead{

  ContratosEstatus estatus = Get.put(ContratosEstatus());
  ContratosDetalle detalle = Get.put(ContratosDetalle());

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
          PullDownMenuItem(
            onTap: (){_showModal(estatus.contenidoEstatus());},
            title: 'Estatus',
            icon: CupertinoIcons.check_mark_circled_solid,
            iconColor: Colors.green,
          ),
          PullDownMenuItem(
            onTap: (){
              Get.toNamed('/previewProfileCuidador');
            },
            title: 'Ver Perfil',
            icon: CupertinoIcons.person_alt_circle_fill,
          ),
          PullDownMenuItem(
            onTap: (){_showModal(detalle.contenidoDetalle());},
            title: 'Detalle',
            icon: CupertinoIcons.square_list_fill,
          ),
          PullDownMenuItem(
            onTap: (){_showConfirmCancel();},
            title: 'Cancelar',
            icon: CupertinoIcons.xmark_circle_fill,
            iconColor: Colors.red,
            isDestructive: true,
          ),
        ];
      },
    );
  }

  void _showModal(Widget content){
    showBarModalBottomSheet(
      context: Get.context!, 
      builder: (context){
        return Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.9,
          child: content,
        );
      }
    );
  }

  void _showConfirmCancel(){
    showBarModalBottomSheet(
      context: Get.context!, 
      builder: (context){
        return Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.2,
          child: Column(
            children: [
              const Text('¿Estás seguro de cancelar el contrato?', style: TextStyle(fontSize: 20),),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CupertinoButton(
                    onPressed: (){},
                    child: const Text('Cancelar', style: TextStyle(color: Colors.grey),),
                  ),
                  CupertinoButton(
                    onPressed: (){},
                    child: const Text('Aceptar', style: TextStyle(color: Colors.green),),
                  ),
                ],
              )
            ],
          ),
        );
      }
    );
  }

}