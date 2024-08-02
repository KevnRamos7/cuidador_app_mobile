import 'package:cuidador_app_mobile/Domain/Model/Objects/lista_contratos.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/list_contrato_controller.dart';
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
              Text('${contrato.personaCliente!.nombre} ${contrato.personaCliente!.apellidoPaterno} ${contrato.personaCliente!.apellidoMaterno}', 
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

  Widget _notFoundContratos(){
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.doc_on_clipboard, size: 100, color: Colors.blueGrey,),
          SizedBox(height: 20,),
          Text('No hay contratos para esta fecha', style: TextStyle(fontSize: 20),)
        ],
      ),
    );
  }

}