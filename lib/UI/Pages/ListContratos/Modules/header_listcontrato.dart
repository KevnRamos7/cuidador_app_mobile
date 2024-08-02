import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/list_contrato_controller.dart';

class HeaderListcontrato{

  LetterDates letter = LetterDates();
  //Crea lazyput de la clase listaContratoscontroller


    Widget encabezado(){
    Get.lazyPut<ListContratoController>(() => ListContratoController());
    ListContratoController con = Get.find();
    return Container(
      padding: const EdgeInsets.only(left: 30),
      height: Get.height * 0.2,
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Historial", 
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
          ),
          const Text("De Cuidados", 
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 20,),
          Text(letter.formatearSoloFecha(con.fechaSeleccionada.toString()), 
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 92, 91, 91)),
          ),
        ],
      ),
    );
  }

  Widget listaFechas(){
    Get.lazyPut<ListContratoController>(() => ListContratoController());
    ListContratoController con = Get.find();
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: Get.height * 0.2,
      width: Get.width,
      child: CalendarTimeline(
        initialDate: con.fechaSeleccionada,
        firstDate: con.fechaSeleccionada,
        lastDate: DateTime.now().add(const Duration(days: 100)),
        onDateSelected: (date) {
          con.changeFechaSeleccionada(date);
        },
        leftMargin: 20,
        monthColor: Colors.blueGrey,
        dayColor: Colors.teal[200],
        activeDayColor: Colors.white,
        activeBackgroundDayColor: Colors.blueGrey,
        // selectableDayPredicate: (date) => date.day != 23,
        locale: 'es_ES',
      )
    );
  }

}