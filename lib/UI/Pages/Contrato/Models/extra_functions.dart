import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:get/get.dart';

import '../../../../Domain/Model/Contrato/tareas_contrato_model.dart';

class ExtraFunctions{

RxList<String> onlyForStartTime(List<ContratoItemModel> scheduleJson, DateTime date){

  RxList<String> horasDisponibles = generateAvailableTimes(scheduleJson, date);

  List<DateTime> convertToDateTimeList(List<String> horas) {
  DateTime now = DateTime.now();
  return horas.map((hora) {
    return DateTime(now.year, now.month, now.day,
        int.parse(hora.split(':')[0]),
          int.parse(hora.split(':')[1]));
    }).toList();
  }

  List<DateTime> horasDateTime = convertToDateTimeList(horasDisponibles);
  
  // Ordenar las horas cronológicamente.
  horasDateTime.sort();

  List<String> nonConformingHours = [];
  
  for (int i = 1; i < horasDateTime.length; i++) {
    DateTime previousTime = horasDateTime[i - 1];
    DateTime currentTime = horasDateTime[i];
    
    Duration difference = currentTime.difference(previousTime);
    
    // Verificar si la diferencia no es de 15 minutos.
    if (difference.inMinutes != 15) {
      nonConformingHours.add(formatTime(currentTime));
    }
  }

  List<int> indicesHorasNoConformes = [];
  for (String hora in nonConformingHours) {
    indicesHorasNoConformes.add(horasDisponibles.indexOf(hora));
  }

  // Quitar las 4 horas anteriores a los indices de las horas no conformes.
  for (int i = 0; i < indicesHorasNoConformes.length; i++) {
    int index = indicesHorasNoConformes[i];
    int start = index - 4;
    int end = index;
    if (start >= 0) {
      horasDisponibles.removeRange(start, end);
    }
  }
  return horasDisponibles;
}

List<String> findDatesWithLessThanOneHour(List<ContratoItemModel> scheduleJson, DateTime date) {
  Map<String, double> dateHoursMap = {};

  // Iterate through each schedule entry
  for (ContratoItemModel entry in scheduleJson) {
    DateTime start = entry.horarioInicioPropuesto!;
    DateTime end = entry.horarioFinPropuesto!;

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
      datesWithLessThanOneHour.add(date.toString());
    }
  });

  return datesWithLessThanOneHour;
}

RxList<String>  generateAvailableTimes(List<ContratoItemModel> scheduleJson, DateTime date) {

  List<String> horasDisponibles = [];

  String dateS =  date.toString().split(" ")[0];
  // String horarioInicioS = hor
  // filtra la lista de todas las fechas ocupadas por el dia pasado por parametro
  List<ContratoItemModel> listafiltradaFecha = scheduleJson.where((e) => 
    e.horarioInicioPropuesto!.toString()
    .contains(dateS)).toList();

  // Genera una lista de las horas posibles (24 horas * 4 intervalos por hora = 96 combinaciones)
  List<String> allTimes = [];
  for (int hour = 0; hour < 24; hour++) {
    for (int minute = 0; minute < 60; minute += 15) {
      allTimes.add("$hour:${minute.toString().padLeft(2, '0')}");
    }
  }

  // Itera sobre los elementos de la lista de fechas ocupadas
  for (var entry in listafiltradaFecha) {
    // DateTime start = DateTime.parse(entry.horarioInicioPropuesto!);
    // DateTime end = DateTime.parse(entry.horarioFinPropuesto!);

    // Quita las horas de inicio y fin de la lista de todas las horas del dia
    allTimes.remove("${entry.horarioInicioPropuesto!.hour}:${entry.horarioInicioPropuesto!.minute.toString().padLeft(2, '0')}");
    allTimes.remove("${entry.horarioFinPropuesto!.hour}:${entry.horarioFinPropuesto!.minute.toString().padLeft(2, '0')}");

    // Calcula los minutos de inicio y fin
    int startMinutes = entry.horarioInicioPropuesto!.hour * 60 + entry.horarioInicioPropuesto!.minute;
    int endMinutes = entry.horarioFinPropuesto!.hour * 60 + entry.horarioFinPropuesto!.minute;

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
      // DateTime start = DateTime.parse(entry.horarioInicioPropuesto!);
      // DateTime end = DateTime.parse(entry.horarioFinPropuesto!);


    String horarioInicioFormatted = "${entry.horarioInicioPropuesto!.hour.toString().padLeft(2, '0')}:${entry.horarioInicioPropuesto!.minute.toString().padLeft(2, '0')}";

    String horarioFinFormatted = "${entry.horarioFinPropuesto!.hour.toString().padLeft(2, '0')}:${entry.horarioFinPropuesto!.minute.toString().padLeft(2, '0')}";

      /// Construir la cadena de fecha y hora completa para start y end
      String dateFormatted = date.toString().split(" ")[0];
      String startDateTimeStr =
          "$dateFormatted ${horarioInicioFormatted.padLeft(5, '0')}";
      String endDateTimeStr =
          "$dateFormatted ${horarioFinFormatted.padLeft(5, '0')}";

      // Verificar si currentTime está dentro del intervalo ocupado
      //return false;
      return entry.horarioInicioPropuesto!.isBefore(DateTime.parse(startDateTimeStr)) &&
          entry.horarioFinPropuesto!.isAfter(DateTime.parse(endDateTimeStr));
    });

    if (!isInSchedule) {
      // Si la hora actual no está en un intervalo ocupado, revisar si la hora anterior lo está
      if (i > 0) {
        String previousTime = allTimes[i - 1];
        bool isPreviousInSchedule = scheduleJson.any((entry) {

          String dateFormatted = date.toString().split(" ")[0];

          return entry.horarioInicioPropuesto!.isBefore(
                  DateTime.parse("$dateFormatted ${previousTime.padLeft(5, '0')}")) &&
              entry.horarioFinPropuesto!.isAfter(
                  DateTime.parse("$dateFormatted ${previousTime.padLeft(5, '0')}"));
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
  
List<String> availableTimesForTask(DateTime fechaInicio, DateTime fechaFin, List<TareasContratoModel> ocupadas) {

  // Inicializar una lista para almacenar las horas disponibles
  List<String> horasEnRango = [];

  // Iterar desde la hora de inicio hasta la hora de fin en intervalos de 15 minutos
  DateTime current = fechaInicio;
  while (current.isBefore(fechaFin)) {
    // Formatear la hora y agregarla a la lista
    String formattedTime = formatTime(current);
    horasEnRango.add(formattedTime);

    // Incrementar 15 minutos
    current = current.add(const Duration(minutes: 10));
  }

  // Filtrar las horas ocupadas
  for (var tarea in ocupadas) {
    String task = tarea.fechaRealizar.toString().split(" ")[1].substring(0, 5);
    horasEnRango.remove(task);
  }
  // horasEnRango.add('');
  // Devolver la lista de horas en rango
  return horasEnRango;
}

List<String> selectedTimeEnd(List<String> horasDisponibles, DateTime horarioInicio) {

  List<String> horasDisponiblesEnd = horasDisponibles;

  // DateTime horaInicial = stringToDateTime(horarioInicio);
  
  DateTime stringHorasDisponibles (String horario){
    int hora = 0;
    int minuto = 0;
    hora = int.parse(horario.substring(0, horario.indexOf(":") ));
    minuto = int.parse(horario.substring(horario.indexOf(":") + 1, horario.indexOf(":") + 3 ));
    DateTime dateFormatted =DateTime(
      horarioInicio.year,
      horarioInicio.month,
      horarioInicio.day,
      hora,
      minuto,
      0, 0
    );
    return dateFormatted;
  }

    String formatTime(DateTime dateTime) {
    String hours = dateTime.hour.toString();
    String minutes = dateTime.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  DateTime lastTime = horarioInicio.subtract(const Duration(minutes: 15));
  List<DateTime> horasDisponiblesDt = horasDisponiblesEnd.map((e) => stringHorasDisponibles(e)).toList();
  for (DateTime hora in horasDisponiblesDt) {
    if(hora.isBefore(horarioInicio)){
      String horaF = formatTime(hora);
      horasDisponiblesEnd.remove(horaF);
    }
    //Si la hora anterior mas 15 minutos es mayor a la hora en curso, se elimina, si no se actualiza la variable lastTime
    else if(lastTime.add(const Duration(minutes: 15)).isBefore(hora) ){
      horasDisponiblesEnd.remove(formatTime(hora));
    }
    else{
      lastTime = hora;
    }
  }

  if(horasDisponiblesEnd.length < 5){
    horasDisponiblesEnd.clear();
  }

  return horasDisponiblesEnd.length >= 4 ? horasDisponiblesEnd.sublist(4) : horasDisponiblesEnd;
}

// Función para formatear DateTime a una cadena con formato HH:mm
String formatTime(DateTime dateTime) {
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
      hora = int.parse(datetime.substring(12, 14));
      minuto = int.parse(datetime.substring(16, 18));

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