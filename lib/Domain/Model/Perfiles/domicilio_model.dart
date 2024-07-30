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
    // required this.fechaRegistro,
    // required this.usuarioRegistro,
    // this.fechaModificacion,
    // this.usuarioModifico,
  });

  /// Crea una instancia de DomicilioModel a partir de un Map JSON.
  factory DomicilioModel.fromJson(Map<String, dynamic> json) {
    return DomicilioModel(
      idDomicilio: json['id_domicilio'],
      calle: json['calle'],
      colonia: json['colonia'],
      numeroInterior: json['numero_interior'],
      numeroExterior: json['numero_exterior'],
      ciudad: json['ciudad'],
      estado: json['estado'],
      pais: json['pais'] ?? "MÉXICO",
      referencias: json['referencias'],
      estatusId: json['estatus_id'],
      // fechaRegistro: DateTime.parse(json['fecha_registro']),
      // usuarioRegistro: json['usuario_registro'],
      // fechaModificacion: json['fecha_modificacion'] != null ? DateTime.parse(json['fecha_modificacion']) : null,
      // usuarioModifico: json['usuario_modifico'],
    );
  }

  /// Convierte una instancia de DomicilioModel a un Map JSON.
  Map<String, dynamic> toJson() {
    return {
      'id_domicilio': idDomicilio,
      'calle': calle,
      'colonia': colonia,
      'numero_interior': numeroInterior,
      'numero_exterior': numeroExterior,
      'ciudad': ciudad,
      'estado': estado,
      'pais': pais,
      'referencias': referencias,
      'estatus_id': estatusId,
      'fecha_registro': fechaRegistro?.toIso8601String(),
      'usuario_registro': usuarioRegistro,
      'fecha_modificacion': fechaModificacion?.toIso8601String(),
      'usuario_modifico': usuarioModifico,
    };
  }
}
