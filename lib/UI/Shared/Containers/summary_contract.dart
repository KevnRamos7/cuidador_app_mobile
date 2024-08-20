import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryContract{

  LetterDates letter = LetterDates();

  Widget tableForSchedules(ContratoModel contrato) {
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
        rows: contrato.contratoItem?.map((e) => DataRow(
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

  Widget tableForTask(ContratoModel contrato){
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
          DataColumn(label: Text('Contrato', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
        ],
        rows: _buildDataRows(contrato),
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

  Widget encabezado(String title){
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

  Widget cuidadorCard({
    required String nombrePersona,
    required String subtitulo,
    required List<String> masdatos,
    required String costoTotal,
    required String contratosLigados,
    required String imagenPerfil
  }){
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
                      child: Text(nombrePersona,style: const TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.black)),
                    ),
                   ],
                 ),
          
                SizedBox(
                  height: Get.height * 0.08,
                  width: Get.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                            
                      Text(subtitulo, textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                            
                       Text(
                        masdatos[0],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),

                            
                      Text(
                        masdatos[0],
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
                              costoTotal,
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
                              contratosLigados,
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
              width: 50,
              height: 50,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(imagenPerfil, 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Image(image: AssetImage('assets/img/shared/avatar_default.jpg'), width: 150, height: 150, fit: BoxFit.cover);
                  },
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget observacionesCard(ContratoModel contrato){
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
        rows: contrato.contratoItem?.map((e) => DataRow(
          cells: [
            DataCell(Text((contrato.contratoItem!.indexOf(e) + 1).toString(), 
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