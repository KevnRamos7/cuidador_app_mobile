import 'package:cuidador_app_mobile/Domain/Model/Catalogos/padecimientos_model.dart';

/// Modelo de datos para los datos médicos.
class DatosMedicosModel {
  int? idDatosMedicos;
  List<PadecimientosModel>? padecimientos;
  String? antecedentesMedicos;
  String? alergias;
  String? tipoSanguineo;
  String? nombreMedicoFamiliar;
  String? telefonoMedicoFamiliar;
  String? observaciones;

  /// Constructor de la clase DatosMedicosModel.
  DatosMedicosModel({
    this.idDatosMedicos,
    this.padecimientos,
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
      idDatosMedicos: json['idDatosmedicos'],
      padecimientos: json['padeicimientos'] != null ? (json['padecimientos'] as List).map((v) => PadecimientosModel.fromJson(v)).toList() : null,
      antecedentesMedicos: json['antecedentesMedicos'],
      alergias: json['alergias'],
      tipoSanguineo: json['tipoSanguineo'],
      nombreMedicoFamiliar: json['nombreMedicofamiliar'],
      telefonoMedicoFamiliar: json['telefonoMedicofamiliar'],
      observaciones: json['observaciones']
    );
  }

  /// Convierte una instancia de DatosMedicosModel a un Map JSON.
  Map<String, dynamic> toJson() {
    return {
      'idDatosMedicos': idDatosMedicos,
      'antecedentesMedicos': padecimientos,
      'alergias': alergias,
      'tipoSanguineo': tipoSanguineo,
      'nombreMedicoFamiliar': nombreMedicoFamiliar,
      'telefonoMedicoFamiliar': telefonoMedicoFamiliar,
      'observaciones': observaciones
    };
  }
}
