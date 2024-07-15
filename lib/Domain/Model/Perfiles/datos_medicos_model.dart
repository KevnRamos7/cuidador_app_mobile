/// Modelo de datos para los datos médicos.
class DatosMedicosModel {
  int? idDatosMedicos;
  String? antecedentesMedicos;
  String? alergias;
  String? tipoSanguineo;
  String? nombreMedicoFamiliar;
  String? telefonoMedicoFamiliar;
  String? observaciones;
  DateTime? fechaRegistro;
  int? usuarioRegistro;
  DateTime? fechaModificacion;
  int? usuarioModifico;

  /// Constructor de la clase DatosMedicosModel.
  DatosMedicosModel({
    this.idDatosMedicos,
    this.antecedentesMedicos,
    this.alergias,
    this.tipoSanguineo,
    this.nombreMedicoFamiliar,
    this.telefonoMedicoFamiliar,
    this.observaciones,
    required this.fechaRegistro,
    required this.usuarioRegistro,
    this.fechaModificacion,
    this.usuarioModifico,
  });

  /// Crea una instancia de DatosMedicosModel a partir de un Map JSON.
  factory DatosMedicosModel.fromJson(Map<String, dynamic> json) {
    return DatosMedicosModel(
      idDatosMedicos: json['id_datosmedicos'],
      antecedentesMedicos: json['antecedentes_medicos'],
      alergias: json['alergias'],
      tipoSanguineo: json['tipo_sanguineo'],
      nombreMedicoFamiliar: json['nombre_medicofamiliar'],
      telefonoMedicoFamiliar: json['telefono_medicofamiliar'],
      observaciones: json['observaciones'],
      fechaRegistro: DateTime.parse(json['fecha_registro']),
      usuarioRegistro: json['usuario_registro'],
      fechaModificacion: json['fecha_modificacion'] != null ? DateTime.parse(json['fecha_modificacion']) : null,
      usuarioModifico: json['usuario_modifico'],
    );
  }

  /// Convierte una instancia de DatosMedicosModel a un Map JSON.
  Map<String, dynamic> toJson() {
    return {
      'id_datosmedicos': idDatosMedicos,
      'antecedentes_medicos': antecedentesMedicos,
      'alergias': alergias,
      'tipo_sanguineo': tipoSanguineo,
      'nombre_medicofamiliar': nombreMedicoFamiliar,
      'telefono_medicofamiliar': telefonoMedicoFamiliar,
      'observaciones': observaciones,
      'fecha_registro': fechaRegistro?.toIso8601String(),
      'usuario_registro': usuarioRegistro,
      'fecha_modificacion': fechaModificacion?.toIso8601String(),
      'usuario_modifico': usuarioModifico,
    };
  }
}
