class SalarioCuidador {

  int? idSueldoNivel;
  double? precioPorHora;
  String? diaSemana;
  String? horaInicio;
  String? horaFin;
  int? estatus;

  SalarioCuidador({
    this.idSueldoNivel,
    this.precioPorHora,
    this.diaSemana,
    this.horaInicio,
    this.horaFin,
    this.estatus
  });

  factory SalarioCuidador.fromJson(Map<String, dynamic> json) => SalarioCuidador(
    idSueldoNivel: json['idSueldoNivel'],
    precioPorHora: json['precioPorHora'] != null ? json['precioPorHora'].toDouble() : 0.0,
    diaSemana: json['diaSemana'],
    horaInicio: json['horaInicio'],
    horaFin: json['horaFin'],
    estatus: json['estatus']
  );

  Map<String, dynamic> toJson() => {
    'idSueldoNivel': idSueldoNivel,
    'precioPorHora': precioPorHora,
    'diaSemana': diaSemana,
    'horaInicio': horaInicio,
    'horaFin': horaFin,
    'estatus': estatus
  };

}