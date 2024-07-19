import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:get/get.dart';

import '../../../../Domain/Model/Contrato/tareas_contrato_model.dart';

class ExtraFunctions{

List<String> findDatesWithLessThanOneHour(List<ContratoItemModel> scheduleJson, String date) {
  Map<String, double> dateHoursMap = {};

  // Iterate through each schedule entry
  for (ContratoItemModel entry in scheduleJson) {
    DateTime start = DateTime.parse(entry.horarioInicioPropuesto!);
    DateTime end = DateTime.parse(entry.horarioFinPropuesto!);
      
      // Calculate duration in hours
      double durationInHours = end.difference(start).inMinutes / 60;

      // Sum duration for each date
      String dateKey = start.toIso8601String().substring(0, 10); // Key by date (yyyy-MM-dd)
      if (dateHoursMap.containsKey(dateKey)) {
        dateHoursMap[dateKey] = dateHoursMap[dateKey]! + durationInHours;
      } else {
        dateHoursMap[dateKey] = durationInHours;
      }
  }

  // Filter dates with total hours less than 1
  List<String> datesWithLessThanOneHour = [];
  dateHoursMap.forEach((date, hours) {
    if (hours > 15) {
      datesWithLessThanOneHour.add(date);
    }
  });

  return datesWithLessThanOneHour;
}

Future <RxList<String>>  generateAvailableTimes(List<ContratoItemModel> scheduleJson, String date) async {

  List<String> horasDisponibles = [];

  // filtra la lista de todas las fechas ocupadas por el dia pasado por parametro
  List<ContratoItemModel> listafiltradaFecha = scheduleJson.where((e) => e.horarioInicioPropuesto!.contains(date)).toList();

  // Genera una lista de las horas posibles (24 horas * 4 intervalos por hora = 96 combinaciones)
  List<String> allTimes = [];
  for (int hour = 0; hour < 24; hour++) {
    for (int minute = 0; minute < 60; minute += 15) {
      allTimes.add("$hour:${minute.toString().padLeft(2, '0')}");
    }
  }

  // Itera sobre los elementos de la lista de fechas ocupadas
  for (var entry in listafiltradaFecha) {
    DateTime start = DateTime.parse(entry.horarioInicioPropuesto!);
    DateTime end = DateTime.parse(entry.horarioFinPropuesto!);

    // Quita las horas de inicio y fin de la lista de todas las horas del dia
    allTimes.remove("${start.hour}:${start.minute.toString().padLeft(2, '0')}");
    allTimes.remove("${end.hour}:${end.minute.toString().padLeft(2, '0')}");

    // Calcula los minutos de inicio y fin
    int startMinutes = start.hour * 60 + start.minute;
    int endMinutes = end.hour * 60 + end.minute;

    // Quita los intervalos ocupados de la lista de todas las horas
    // Itera sobre cada intervalo de 15 minutos en el rango de horas ocupadas
    for (int minute = startMinutes; minute < endMinutes; minute += 15) {
      int hour = minute ~/ 60;
      int minuteOfHour = minute % 60;
      allTimes.remove("$hour:${minuteOfHour.toString().padLeft(2, '0')}");
    }

  }

  // Filtra las horas que no estan dentro de un intervalo ocupado

  List<String> filteredTimes = [];
  for (int i = 0; i < allTimes.length; i++) {
    String currentTime = allTimes[i];

    // Revisa si la hora del item esta dentro de un intervalo ocupado
    bool isInSchedule = scheduleJson.any((entry) {
      DateTime start = DateTime.parse(entry.horarioInicioPropuesto!);
      DateTime end = DateTime.parse(entry.horarioFinPropuesto!);


      String horarioInicioFormatted = "${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}";

    String horarioFinFormatted = "${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}";

      /// Construir la cadena de fecha y hora completa para start y end
      String startDateTimeStr =
          "$date ${horarioInicioFormatted.padLeft(5, '0')}";
      String endDateTimeStr =
          "$date ${horarioFinFormatted.padLeft(5, '0')}";

      // Verificar si currentTime está dentro del intervalo ocupado
      //return false;
      return start.isBefore(DateTime.parse(startDateTimeStr)) &&
          end.isAfter(DateTime.parse(endDateTimeStr));
    });

    if (!isInSchedule) {
      // Si la hora actual no está en un intervalo ocupado, revisar si la hora anterior lo está
      if (i > 0) {
        String previousTime = allTimes[i - 1];
        bool isPreviousInSchedule = scheduleJson.any((entry) {
          DateTime start = DateTime.parse(entry.horarioInicioPropuesto!);
          DateTime end = DateTime.parse(entry.horarioFinPropuesto!);

          return start.isBefore(
                  DateTime.parse("$date ${previousTime.padLeft(5, '0')}")) &&
              end.isAfter(
                  DateTime.parse("$date ${previousTime.padLeft(5, '0')}"));
        });

        if (!isPreviousInSchedule) {
          filteredTimes.add(currentTime);
        }
      } 
      else 
      {
        filteredTimes.add(currentTime);
      }
    }
  }
  // Agrega las horas filtradas a la lista de horas disponibles
  horasDisponibles.addAll(filteredTimes);

  Map<String, List<String>> intervalosPorHora = {};

  for(String time in filteredTimes){
    String hora = time.split(":")[0];
    // si la hora no existe en el mapa, se crea una lista vacia
    if(!intervalosPorHora.containsKey(hora)){
      intervalosPorHora[hora] = [];
    }
    intervalosPorHora[hora]!.add(time); // se agrega el intervalo a la lista de la hora
  }
  horasDisponibles.clear();
  intervalosPorHora.forEach((hora, times){
    if(times.contains("$hora:00") && times.contains("$hora:15") && times.contains("$hora:30") && times.contains("$hora:45")){
      for (var time in times) {
        horasDisponibles.add(time);
      }
    }
  });

  return horasDisponibles.obs;
}
  
List<String> availableTimesForTask(String fechaInicio, String fechaFin, List<TareasContratoModel> ocupadas) {
  // Parsear las fechas de inicio y fin
  DateTime start = DateTime.parse(fechaInicio);
  DateTime end = DateTime.parse(fechaFin);

  // Inicializar una lista para almacenar las horas disponibles
  List<String> horasEnRango = [];

  // Iterar desde la hora de inicio hasta la hora de fin en intervalos de 15 minutos
  DateTime current = start;
  while (current.isBefore(end)) {
    // Formatear la hora y agregarla a la lista
    String formattedTime = _formatTime(current);
    horasEnRango.add(formattedTime);

    // Incrementar 15 minutos
    current = current.add(const Duration(minutes: 10));
  }

  // Filtrar las horas ocupadas
  for (var tarea in ocupadas) {
    String task = tarea.fechaInicio.toString().split(" ")[1].substring(0, 5);
    horasEnRango.remove(task);
  }

  // Devolver la lista de horas en rango
  return horasEnRango;
}

// Función para formatear DateTime a una cadena con formato HH:mm
String _formatTime(DateTime dateTime) {
  String hours = dateTime.hour.toString().padLeft(2, '0');
  String minutes = dateTime.minute.toString().padLeft(2, '0');
  return '$hours:$minutes';
}

String formatTimeInLetter(String date){
  return '';
}

// Función para formatear string a Datetime
DateTime stringToDateTime(String datetime){
  
  int logitudCadena = datetime.length;
  String fecha = '';
  int hora = 0;
  int minuto = 0;

  switch(logitudCadena){

    case 10:
    // Longitud de la cadena de fecha
      return DateTime(
        int.parse(datetime.substring(0, 4)), // Año
        int.parse(datetime.substring(5, 7)), // Mes
        int.parse(datetime.substring(8, 10)) // Día
      );
    case > 18:
    // Longitud de la cadena de fecha y hora
      fecha = datetime.substring(0, 10);
      hora = int.parse(datetime.substring(12, datetime.indexOf(":") -1 ));
      minuto = int.parse(datetime.substring(datetime.indexOf(":") + 1, datetime.indexOf(":") + 3 ));

      return DateTime(
        int.parse(datetime.substring(0, 4)), // Año
        int.parse(datetime.substring(5, 7)), // Mes
        int.parse(datetime.substring(8, 10)), // Día
        int.parse(datetime.substring(12, datetime.indexOf(":") -1 )), // Hora
        int.parse(datetime.substring(datetime.indexOf(":") + 1, datetime.indexOf(":") + 3 )) // Minuto
      );
    case <= 5:
      hora = int.parse(datetime.substring(0, datetime.indexOf(":") ));
      minuto = int.parse(datetime.substring(datetime.indexOf(":") + 1, datetime.indexOf(":") + 3 ));
      DateTime dateFormatted =DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        hora,
        minuto,
        0, 0
      );
      return dateFormatted;

    default:
      return DateTime.now();
  }

}

}