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
}

String formatearSoloHora(String fechaString) {
  DateTime fecha = DateTime.parse(fechaString);

  String hora = fecha.hour.toString().padLeft(2, '0');
  String minuto = fecha.minute.toString().padLeft(2, '0');

  return '$hora:$minuto';
}


}