class LetterDates{

  String formatearFecha(String fechaString) {

    DateTime fecha = DateTime.parse(fechaString);

    List<String> diasDeLaSemana = [
      'Domingo',
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado'
    ];

    List<String> mesesDelAno = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];

    String diaDeLaSemana = diasDeLaSemana[fecha.weekday % 7];
    String mesDelAno = mesesDelAno[fecha.month - 1];
    String dia = fecha.day.toString();
    String ano = fecha.year.toString();
    String hora = fecha.hour.toString().padLeft(2, '0');
    String minuto = fecha.minute.toString().padLeft(2, '0');

    return '$diaDeLaSemana $dia de $mesDelAno de $ano a las $hora:$minuto';
  }

  String formatearSoloFecha(String fechaString) {
  try {
    DateTime fecha = DateTime.parse(fechaString);

    List<String> diasDeLaSemana = [
      'Domingo',
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado'
    ];

    List<String> mesesDelAno = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];

    String diaDeLaSemana = diasDeLaSemana[fecha.weekday % 7];
    String mesDelAno = mesesDelAno[fecha.month - 1];
    String dia = fecha.day.toString();
    String ano = fecha.year.toString();

    return '$diaDeLaSemana $dia de $mesDelAno de $ano';
  } catch (e) {
    return 'Fecha inválida';
  }
}


String formatearSoloHora(String fechaString) {
  DateTime fecha = DateTime.parse(fechaString);

  String hora = fecha.hour.toString().padLeft(2, '0');
  String minuto = fecha.minute.toString().padLeft(2, '0');

  return '$hora:$minuto';
}

String calcularEdad(String fechaString) {
  DateTime fecha = DateTime.parse(fechaString);
  DateTime ahora = DateTime.now();

  int edad = ahora.year - fecha.year;

  if (ahora.month < fecha.month) {
    edad--;
  } else if (ahora.month == fecha.month) {
    if (ahora.day < fecha.day) {
      edad--;
    }
  }

  return edad.toString();
}

}