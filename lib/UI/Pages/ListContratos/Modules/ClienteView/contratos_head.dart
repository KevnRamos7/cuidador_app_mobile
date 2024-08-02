
import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/list_contrato_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/ClienteView/contratos_detalle.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/ClienteView/contratos_estatus.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/Shared/modal_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../../../../Domain/Model/Objects/lista_contratos.dart';

class ContratosHead{

  ContratosEstatus estatus = Get.put(ContratosEstatus());
  ContratosDetalle detalle = Get.put(ContratosDetalle());
  ModalComponents modalComponents = ModalComponents();
  ListContratoController con = Get.put(ListContratoController());
  LetterDates letter = LetterDates();

  Widget contenido(){
    return Expanded(
      child: Obx(()=>
        con.contratosFiltrados.isEmpty ? _notFoundContratos() :
        ListView.builder(
          itemCount: con.contratosFiltrados.length,
          itemBuilder: (BuildContext context, int index){
            return _contenidoItem(con.contratosFiltrados[index]);
          },
        ),
      )
    );
  }

  Widget _contenidoItem(ListaContratos contrato){
    return GestureDetector(
      child: Card(
        elevation: 2,
        color: contrato.color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(letter.formatearSoloHora(contrato.fechaPrimerContrato.toString()), 
              style: const TextStyle(color: Colors.white, fontSize: 20),),
              Text('${contrato.personaCuidador!.nombre} ${contrato.personaCuidador!.apellidoPaterno} ${contrato.personaCuidador!.apellidoMaterno}', 
              style: const TextStyle(color: Colors.white, fontSize: 15),),
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
            onTap: (){modalComponents.showModal(estatus.contenidoEstatus());},
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
            onTap: (){modalComponents.showModal(detalle.contenidoDetalle());},
            title: 'Detalle',
            icon: CupertinoIcons.square_list_fill,
          ),
          PullDownMenuItem(
            onTap: (){modalComponents.showConfirmCancel(
              message: '¿Estás seguro de cancelar el contrato?',
              onConfirm: (){},
              onCancel: (){}
            );},
            title: 'Cancelar',
            icon: CupertinoIcons.xmark_circle_fill,
            iconColor: Colors.red,
            isDestructive: true,
          ),
        ];
      },
    );
  }

  Widget _notFoundContratos(){
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.doc_on_clipboard, size: 100, color: Colors.grey,),
          Text('Parece que no tienes ningun contrato!', style: TextStyle(fontSize: 20, color: Colors.grey),)
        ],
      ),
    );
  }

}