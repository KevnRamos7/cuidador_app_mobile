class SalarioCuidador {

  int? idSueldoNivel;
  double? precioPorHora;

  SalarioCuidador({
    this.idSueldoNivel,
    this.precioPorHora
  });

  factory SalarioCuidador.fromJson(Map<String, dynamic> json) => SalarioCuidador(
    idSueldoNivel: json['idSueldoNivel'],
    precioPorHora: json['precioPorHora'] != null ? json['precioPorHora'].toDouble() : 0.0
  );

  Map<String, dynamic> toJson() => {
    'idSueldoNivel': idSueldoNivel,
    'precioPorHora': precioPorHora
  };

}