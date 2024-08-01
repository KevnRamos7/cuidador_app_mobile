import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/list_contrato_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Domain/Model/Contrato/contrato_model.dart';

class ContratosDetalle{

  ListContratoController con = Get.put(ListContratoController());
  LetterDates letter = LetterDates();

  Widget contenidoDetalle(){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            cuidadorCard(),
              
            _encabezado('Fechas y Horarios'),
        
            tableForSchedules(),

            _encabezado('Observaciones'),

            _observacionesCard(),
        
            _encabezado('Lista de Tareas'),
        
            tableForTask(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _encabezado(String title){
    return Container(
      margin: EdgeInsets.only(top:  Get.height * 0.06, bottom: Get.height * 0.02),
      width: Get.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 114, 114, 114)), textAlign: TextAlign.start,),
        ],
      ),
    );
  }

  Widget tableForTask(){
    return SizedBox(
      // height: Get.height * 0.3,
      width: Get.width * 0.95,
      child: DataTable(
        headingRowColor: WidgetStateProperty.resolveWith((states) => Colors.grey[100]!),
        headingRowHeight: 40,
        border: TableBorder.all(color: Colors.grey, width: 0.5, borderRadius: BorderRadius.circular(10)),

        columns: const [
          DataColumn(label: Text('Tarea', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Hora', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
          DataColumn(label: Text('N°', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
        ],
        rows: _buildDataRows(con.contrato.value),
      ),
    );
  }

  List<DataRow> _buildDataRows(ContratoModel contratos) {
  List<DataRow> rows = [];
    for (var contratoItem in contratos.contratoItem!) {
      int i = contratos.contratoItem!.indexOf(contratoItem);
      for (var tarea in contratoItem.tareasContrato!) {
        rows.add(
          DataRow(cells: [
            DataCell(Text(tarea.tituloTarea ?? '')),
            DataCell(Text(tarea.fechaRealizar?.toString().isNotEmpty == true ? letter.formatearSoloHora(tarea.fechaRealizar!.toString()) : '')),
            DataCell(Text((i + 1).toString())), // El índice del contrato
          ]),
        );
      }
    }

  return rows;
}

  Widget tableForSchedules(){
    return SizedBox(
      // height: Get.height * 0.3,
      width: Get.width * 0.95,
      child: DataTable(
        headingRowColor: WidgetStateProperty.resolveWith((states) => Colors.grey[100]!),
        headingRowHeight: 40,
        border: TableBorder.all(color: Colors.grey, width: 0.5, borderRadius: BorderRadius.circular(10)),

        columns: const [
          DataColumn(label: Text('Fecha', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Horario', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
        ],
        rows: con.contrato.value.contratoItem?.map((e) => DataRow(
          cells: [
            DataCell(Text(e.horarioInicioPropuesto?.toString().isNotEmpty == true ? letter.formatearSoloFecha(e.horarioInicioPropuesto!.toString()) : '', 
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)
            ),
            DataCell(Text('${letter.formatearSoloHora(e.horarioInicioPropuesto!.toString())} - ${letter.formatearSoloHora(e.horarioFinPropuesto!.toString())}', 
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
          ]
        )).toList() ?? const [],
      ),
    );
  }

  Widget cuidadorCard(){
    return SizedBox(
      height: Get.height * 0.25,
      width: Get.width * 0.9,
      child: Stack(
        children: [
          Container(
            height: Get.height * 0.25,
            width: Get.width * 0.9,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                    SizedBox(
                      height: Get.height * 0.04,
                      child: Text(
                        con.contrato.value.personaCuidador!.nombre ?? '',
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ), 
                                 ),
                    ),
                   ],
                 ),
          
                SizedBox(
                  // color: Colors.amber,
                  height: Get.height * 0.08,
                  width: Get.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                            
                      const Text(
                        'Certificaciones',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                      ),
                            
                       Text(
                        con.contrato.value.personaCuidador?.certificaciones?.isNotEmpty == true
                          ? con.contrato.value.personaCuidador!.certificaciones![0].tipoCerficacion ?? ''
                          : '',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),

                            
                      Text(
                        con.contrato.value.personaCuidador?.certificaciones?.isNotEmpty == true
                          ? con.contrato.value.personaCuidador!.certificaciones![1].tipoCerficacion ?? ''
                          : 'Sin certificaciones',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                            
                    ],
                  ),
                ),
          
                SizedBox(
                  // color: Colors.amber,
                  height: Get.height * 0.05,
                  width: Get.width * 0.9,
                  child: Row(
                    children: [
          
                      SizedBox(
                        height: Get.height * 0.05,
                        width: Get.width * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              'Costo Total',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                              ),
                             ),
                      
                            Text(
                              con.contrato.value.contratoItem?.isNotEmpty == true
                                ? ' \$ ${con.contrato.value.contratoItem!.map((e) => e.importeCuidado).reduce((value, element) => value! + element!).toString()}'
                                : '0',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green[800]
                              ),
                            )
          
                          ],
                        ),
                      ),
          
                      SizedBox(
                        height: Get.height * 0.05,
                        width: Get.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                             const Text(
                              'Contratos Ligados',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                              ),
                            ),
                      
                            Text(
                              con.contrato.value.contratoItem?.isNotEmpty == true
                                ? con.contrato.value.contratoItem!.length.toString()
                                : '0',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.blueGrey
                              ),
                            ) 
                          ],
                        ),
                      )
          
                    ],
                  ),
                )
          
              ],
            )
          ),

          Positioned(
            left: Get.width * 0.69,
            top: 5,
            child: Container(
              width: Get.width * 0.2,
              height: 76.69,
              decoration: ShapeDecoration(
                image: DecorationImage(image: NetworkImage(con.contrato.value.personaCuidador?.avatarImage ?? ''), fit: BoxFit.fill),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
  
  Widget _observacionesCard(){
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.02),
      width: Get.width * 0.95,
      child: DataTable(
        headingRowColor: WidgetStateProperty.resolveWith((states) => Colors.grey[100]!),
        headingRowHeight: 40,
        border: TableBorder.all(color: Colors.grey, width: 0.5, borderRadius: BorderRadius.circular(10)),

        columns: const [
          DataColumn(label: Text('Contrato', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Observación', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
        ],
        rows: con.contrato.value.contratoItem?.map((e) => DataRow(
          cells: [
            DataCell(Text((con.contrato.value.contratoItem!.indexOf(e) + 1).toString(), 
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)
            ),
            DataCell(Text(e.observaciones ?? '', 
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
          ]
        )).toList() ?? const [],
      ),
    );
  }

}