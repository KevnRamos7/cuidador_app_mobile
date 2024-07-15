import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl/date_symbol_data_http_request.dart';
// import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ContratoItemList{

  void mostrarListadofromModalSheet(List<ContratoItemModel> contrato){
    // initializeDateFormatting('es', '');

  //   String formatDate(DateTime date) {
  //   // final DateFormat formatter = DateFormat.yMMMMEEEEd('es_ES');
  //   // return formatter.format(date);
  // }

    showCupertinoModalBottomSheet(
      context: Get.context!, 
      builder: (context) => Material(
        child: SizedBox(
          height: Get.height * 0.5,
          child: Column(
            children: [

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Contratos', 
                    style: TextStyle(fontSize:25, fontWeight: FontWeight.bold),),
                ],
              ),

              SizedBox(height: Get.height * 0.05,),

              Expanded(
                child: ListView.builder(
                  itemCount: contrato.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(CupertinoIcons.eye, color: Colors.blueGrey, size: 20,),
                          // Text(formatDate(DateTime.parse(contrato[index].fechaSolicitaCliente!)), style: const TextStyle(fontSize: 15),),
                          const Icon(CupertinoIcons.xmark, color: Colors.red, size: 20,)
                        ],
                      ),
                      onTap: () => Get.back()
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

}