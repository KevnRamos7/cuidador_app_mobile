
class MetodoPagoUsuario{

  int? idMetodoPagoUsuario;
  int? usuarioId;
  String? nombreBeneficiario;
  String? numeroTarjeta;
  String? fechaVencimiento;
  String? cvv;
  int? vecesUsada;

  MetodoPagoUsuario({
    this.idMetodoPagoUsuario,
    this.usuarioId,
    this.nombreBeneficiario,
    this.numeroTarjeta,
    this.fechaVencimiento,
    this.cvv,
    this.vecesUsada
  });

  factory MetodoPagoUsuario.fromJson(Map<String, dynamic> json) => MetodoPagoUsuario(
    idMetodoPagoUsuario: json['idMetodousuario'],
    usuarioId: json['usuarioId'],
    nombreBeneficiario: json['nombreBeneficiario'],
    numeroTarjeta: json['numeroTarjeta'],
    fechaVencimiento: json['fechaVencimiento'],
    cvv: json['ccv'],
    vecesUsada: json['vecesUsada']
  );

  Map<String, dynamic> toJson() => {
    'idMetodousuario': idMetodoPagoUsuario,
    'usuarioId': usuarioId,
    'nombreBeneficiario': nombreBeneficiario,
    'numeroTarjeta': numeroTarjeta,
    'fechaVencimiento': fechaVencimiento,
    'ccv': cvv,
    'vecesUsada': vecesUsada
  };

}