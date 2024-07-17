import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';

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

  List<String> generateAvailableTimes(List<ContratoItemModel> scheduleJson, String date) {
  
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

    // Calcula los minutos de inicio y fin
    int startMinutes = start.hour * 60 + start.minute;
    int endMinutes = end.hour * 60 + end.minute;

    // Quita los intervalos ocupados de la lista de todas las horas
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

      /// Construir la cadena de fecha y hora completa para start y end
      String startDateTimeStr = "$date ${entry.horarioInicioPropuesto!.padLeft(5, '0')}";
      String endDateTimeStr = "$date ${entry.horarioFinPropuesto!.padLeft(5, '0')}";

      // Verificar si currentTime está dentro del intervalo ocupado
      // return false;
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

          return start.isBefore(DateTime.parse("$date ${previousTime.padLeft(5, '0')}")) &&
                 end.isAfter(DateTime.parse("$date ${previousTime.padLeft(5, '0')}"));
        });

        if (!isPreviousInSchedule) {
          filteredTimes.add(currentTime);
        }
      } else {
        filteredTimes.add(currentTime);
      }
    }
  }

  // Agrega las horas filtradas a la lista de horas disponibles
  horasDisponibles.addAll(filteredTimes);

  return horasDisponibles;
}

}