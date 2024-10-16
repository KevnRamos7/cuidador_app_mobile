/// Modelo de datos para un domicilio.
class DomicilioModel {
  int? idDomicilio;
  String? calle;
  String? colonia;
  String? numeroInterior;
  String? numeroExterior;
  String? ciudad;
  String? estado;
  String? pais;
  String? referencias;
  int? estatusId;
  DateTime? fechaRegistro;
  int? usuarioRegistro;
  DateTime? fechaModificacion;
  int? usuarioModifico;

  /// Constructor de la clase DomicilioModel.
  DomicilioModel({
    this.idDomicilio,
    this.calle,
    this.colonia,
    this.numeroInterior,
    this.numeroExterior,
    this.ciudad,
    this.estado,
    this.pais = "MÉXICO", // Valor por defecto
    this.referencias,
    this.estatusId,
  });

  /// Crea una instancia de DomicilioModel a partir de un Map JSON.
  factory DomicilioModel.fromJson(Map<String, dynamic> json) {
    return DomicilioModel(
      idDomicilio: json['idDomicilio'],
      calle: json['calle'],
      colonia: json['colonia'],
      numeroInterior: json['numeroInterior'],
      numeroExterior: json['numeroExterior'],
      ciudad: json['ciudad'],
      estado: json['estado'],
      pais: json['pais'] ?? "MÉXICO",
      referencias: json['referencias'],
      estatusId: json['estatusId'],
    );
  }

  /// Convierte una instancia de DomicilioModel a un Map JSON.
  Map<String, dynamic> toJson() {
    return {
      'idDomicilio': idDomicilio,
      'calle': calle,
      'colonia': colonia,
      'numeroInterior': numeroInterior,
      'numeroExterior': numeroExterior,
      'ciudad': ciudad,
      'estado': estado,
      'pais': pais,
      'referencias': referencias,
      'estatusId': estatusId,
    };
  }
}
