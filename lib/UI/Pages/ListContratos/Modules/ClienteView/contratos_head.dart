
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/list_contrato_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/ClienteView/contratos_detalle.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/Shared/modal_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../../../../Domain/Model/Objects/lista_contratos.dart';

class ContratosHead{

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
          child: Obx(()=>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(letter.formatearSoloHora(contrato.horarioInicio.toString()), 
                style: const TextStyle(color: Colors.white, fontSize: 20),),
                Text('${contrato.personaCuidador!.nombre} ${contrato.personaCuidador!.apellidoPaterno} ${contrato.personaCuidador!.apellidoMaterno}', 
                style: const TextStyle(color: Colors.white, fontSize: 15),),
                con.statusDetalleLoading.value == true || con.statusContratoLoading.value == true ? const CupertinoActivityIndicator() :
                 _showPullMenu(contrato.idContratoItem!, contrato),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PullDownButton _showPullMenu(int index, ListaContratos contrato){
    
    Map<int, Map<IconData, Color>> iconos = {
      7: {CupertinoIcons.check_mark_circled_solid: Colors.green},
      8: {CupertinoIcons.xmark_circle_fill: Colors.red},
      9: {CupertinoIcons.checkmark_shield_fill: Colors.grey},
      18: {CupertinoIcons.clock_solid: Colors.yellow[800]!},
      19: {CupertinoIcons.timer_fill: Colors.orange},
    };

    int idEstatus = contrato.estatus!.idEstatus!;

    // Obtener el ícono y color correspondiente al estatus usando el idEstatus
    var estatusData = iconos[contrato.estatus!.idEstatus];
    IconData? iconData;
    Color? iconColor;

    if (estatusData != null) {
      iconData = estatusData.keys.first;
      iconColor = estatusData.values.first;
    } else {
      // Opcional: Define un ícono y color por defecto si el estatus no está en el mapa
      iconData = CupertinoIcons.question_circle;
      iconColor = Colors.grey;
    }

    return PullDownButton(
      buttonBuilder: (context, showMenu) => CupertinoButton(
        onPressed: showMenu,
        padding: const EdgeInsets.all(0),
        child: const Icon(CupertinoIcons.ellipsis, color: Colors.white, size: 15,)
      ) ,
      itemBuilder: (context) {
        return [
          PullDownMenuItem(
            onTap: () async{
              await con.getEstatusContratoCliente(contrato.idContratoItem!);
            },
            title: 'Estatus',
            icon: iconData ?? CupertinoIcons.check_mark_circled_solid,
            iconColor: iconColor ?? Colors.grey,
          ),
          PullDownMenuItem(
            onTap: (){
              Get.toNamed('/previewProfileCuidador', arguments: contrato.personaCuidador!.idPersona);
            },
            title: 'Ver Perfil',
            icon: CupertinoIcons.person_alt_circle_fill,
          ),
          PullDownMenuItem(
            onTap: () async{
              await con.getDetalleContrato(index);
              modalComponents.showModal(detalle.contenidoDetalle());
            },
            title: 'Detalle',
            icon: CupertinoIcons.square_list_fill,
          ),
          idEstatus == 9 ? const PullDownMenuActionsRow.small(items: []) : PullDownMenuItem(
            onTap: () async{
              Get.toNamed('/listComentarios', arguments: contrato);
            },
            title: 'Dejar Reseña',
            icon: CupertinoIcons.star_fill,
            iconColor: Colors.blue,
          ),
          idEstatus != 8 && idEstatus != 9 && idEstatus != 19 ? 
          PullDownMenuItem(
            onTap: (){modalComponents.showConfirmCancel(
              message: '¿Estás seguro de cancelar el contrato?',
              onConfirm: () async{
                Get.back();
                await con.cambiarEstatusContrato(contrato.idContratoItem!, 8);
              },
              onCancel: ()=> Get.back()
            );},
            title: 'Cancelar',
            icon: CupertinoIcons.xmark_circle_fill,
            iconColor: Colors.red,
            isDestructive: true,
          ) : const PullDownMenuActionsRow.small(items: []),
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