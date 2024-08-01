import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderListcontrato{

    Widget encabezado(){
    return Container(
      padding: const EdgeInsets.only(left: 30),
      height: Get.height * 0.2,
      width: Get.width,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Historial", 
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
          ),
          Text("De Cuidados", 
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 20,),
          Text('Martes, 20 de Julio de 2024', 
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 92, 91, 91)),
          ),
        ],
      ),
    );
  }

  Widget listaFechas(){
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: Get.height * 0.2,
      width: Get.width,
      child: CalendarTimeline(
        initialDate: DateTime(2020, 4, 20),
        firstDate: DateTime(2019, 1, 15),
        lastDate: DateTime(2020, 11, 20),
        onDateSelected: (date) {},
        leftMargin: 20,
        monthColor: Colors.blueGrey,
        dayColor: Colors.teal[200],
        activeDayColor: Colors.white,
        activeBackgroundDayColor: Colors.blueGrey,
        selectableDayPredicate: (date) => date.day != 23,
        locale: 'es_ES',
      )
    );
  }

}