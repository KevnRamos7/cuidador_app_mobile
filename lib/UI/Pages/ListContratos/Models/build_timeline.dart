import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../Domain/Model/Objects/eventos_contrato_model.dart';

class BuildTimeline{

  List<TimelineTile> timelist = [];
  LetterDates letter = LetterDates();

  List<Map<String, Color>> colores = [
    {'Aceptado': const Color(0xFF1E6892)},
    {'Iniciado': const Color(0xFF1E6892)},
    {'Pendiente': Colors.grey},
    {'Finalizado': Colors.green},
  ];

  List<TimelineTile> construirLista(List<EventosContratoModel> eventos){
    for (var element in eventos) {
      timelist.add(
        TimelineTile(
          alignment: TimelineAlign.start,
          lineXY: 0.6,
          isFirst: eventos.indexOf(element) == 0 ? true : false,
          isLast: eventos.indexOf(element) == eventos.length - 1 ? true : false,
          indicatorStyle: IndicatorStyle(
            width: 20,
            color: colores[0][element.estatus] ?? Colors.grey,
            // color: colores[0][element.estatus] ?? Colors.grey,
            padding: const EdgeInsets.all(8),
          ),
          endChild: SizedBox(
            width: Get.width * 0.9,
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(element.titulo ?? 'Sin Titulo', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                Text((element.fecha != null ? letter.formatearFecha(element.fecha.toString()) : 'No Iniciada'), 
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey), textAlign: TextAlign.center
                ),
              ],
            ),
          )
        )
      );
    }
    return timelist;
  }

}