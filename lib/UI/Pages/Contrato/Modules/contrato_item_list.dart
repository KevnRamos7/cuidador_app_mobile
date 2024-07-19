import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Shared/TextFields/search_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_down_button/pull_down_button.dart';

class ContratoItemList{

  SearchTextfield searchTextfield = SearchTextfield();
  LetterDates letterDates = LetterDates();

  void mostrarListadofromModalSheet(List<ContratoItemModel> contrato){

    showCupertinoModalBottomSheet(
      context: Get.context!, 
      builder: (context) => Material(
        child: SizedBox(
          height: Get.height * 0.5,
          child: Column(
            children: [

              const Padding(
                padding: EdgeInsets.only(top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Contratos Por Fecha', 
                      style: TextStyle(fontSize:25, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),

              SizedBox(height: Get.height * 0.05,),

              Expanded(
                child: ListView.builder(
                  itemCount: contrato.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        tileColor: Colors.blueGrey[900],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        trailing: pullDownButton((index + 1).toString(), contrato[index].tareasContrato!.length.toString()),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20),
                            Text(
                              letterDates.formatearFecha(contrato[index].horarioInicioPropuesto!).toString(), 
                              style: const TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                        onTap: () => Get.back()
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  PullDownButton pullDownButton(String indexContrato, String tareasAsignadas){
    return PullDownButton(
      itemBuilder: (context) =>[
        PullDownMenuHeader(
          leading: Container(
            color: Colors.blueGrey, 
            child: const Icon(CupertinoIcons.rectangle_fill_on_rectangle_angled_fill, color: Colors.white,)), 
          title: 'Contrato Número $indexContrato',
          subtitle: '$tareasAsignadas Tareas Asignadas',
          onTap: (){},
        ),
        const PullDownMenuDivider.large(),
        PullDownMenuActionsRow.medium(
          items: [
            PullDownMenuItem(onTap: (){}, title: 'Ver Detalle', icon: CupertinoIcons.eye),
            PullDownMenuItem(onTap: (){}, title: 'Editar',icon: CupertinoIcons.pencil_circle),
            PullDownMenuItem(onTap: (){}, title: 'Eliminar', icon: CupertinoIcons.delete),
          ]
        )
      ], 
      buttonBuilder: (context, showMenu) => CupertinoButton(
        onPressed: showMenu,
        padding: const EdgeInsets.all(0),
        child: const Icon(CupertinoIcons.ellipsis_circle, color: Colors.white,)
      ) 
    );
  }

}