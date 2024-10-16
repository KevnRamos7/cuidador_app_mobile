/// Modelo de datos para los datos médicos.
class DatosMedicosModel {
  int? idDatosMedicos;
  String? antecedentesMedicos;
  String? alergias;
  String? tipoSanguineo;
  String? nombreMedicoFamiliar;
  String? telefonoMedicoFamiliar;
  String? observaciones;

  /// Constructor de la clase DatosMedicosModel.
  DatosMedicosModel({
    this.idDatosMedicos,
    this.antecedentesMedicos,
    this.alergias,
    this.tipoSanguineo,
    this.nombreMedicoFamiliar,
    this.telefonoMedicoFamiliar,
    this.observaciones
  });

  /// Crea una instancia de DatosMedicosModel a partir de un Map JSON.
  factory DatosMedicosModel.fromJson(Map<String, dynamic> json) {
    return DatosMedicosModel(
      idDatosMedicos: json['idDatosMedicos'],
      antecedentesMedicos: json['antecedentesMedicos'],
      alergias: json['alergias'],
      tipoSanguineo: json['tipo_sanguineotipoSanguineo'],
      nombreMedicoFamiliar: json['nombreMedicoFamiliar'],
      telefonoMedicoFamiliar: json['telefonoMedicoFamiliar'],
      observaciones: json['observaciones']
    );
  }

  /// Convierte una instancia de DatosMedicosModel a un Map JSON.
  Map<String, dynamic> toJson() {
    return {
      'idDatosMedicos': idDatosMedicos,
      'antecedentesMedicos': antecedentesMedicos,
      'alergias': alergias,
      'tipoSanguineo': tipoSanguineo,
      'nombreMedicoFamiliar': nombreMedicoFamiliar,
      'telefonoMedicoFamiliar': telefonoMedicoFamiliar,
      'observaciones': observaciones
    };
  }
}
