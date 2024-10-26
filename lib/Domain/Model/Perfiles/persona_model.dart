import 'package:cuidador_app_mobile/Domain/Model/Perfiles/certificaciones_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/datos_medicos_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/documentacion_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/domicilio_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

/// Modelo de datos para una persona.
class PersonaModel {
  int? idPersona;
  String? nombre;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? correoElectronico;
  String? fechaNacimiento;
  String? genero;
  String? estadoCivil;
  String? rfc;
  String? curp;
  String? telefonoParticular;
  String? telefonoMovil;
  String? telefonoEmergencia;
  String? nombreCompletoFamiliar;
  DomicilioModel? domicilio;
  DatosMedicosModel? datosMedicos;
  RxList<CertificacionesModel>? certificaciones;
  String? avatarImage;
  Color? colorBg = Colors.white;
  String? estatus;
  DocumentacionModel? documentacion;
  DateTime? fechaRegistro;

  /// Constructor de la clase PersonaModel.
  PersonaModel({
    this.idPersona,
    this.nombre,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.correoElectronico,
    this.fechaNacimiento,
    this.genero,
    this.estadoCivil,
    this.rfc,
    this.curp,
    this.telefonoParticular,
    this.telefonoMovil,
    this.telefonoEmergencia,
    this.nombreCompletoFamiliar,
    this.domicilio,
    this.datosMedicos,
    this.certificaciones,
    this.avatarImage,
    this.estatus,
    this.documentacion,
    this.fechaRegistro
  });

  /// Crea una instancia de PersonaModel a partir de un Map JSON.
  factory PersonaModel.fromJson(Map<String, dynamic> json) {
    return PersonaModel(
      idPersona: json['idPersona'],
      nombre: json['nombre'],
      apellidoPaterno: json['apellidoPaterno'],
      apellidoMaterno: json['apellidoMaterno'],
      correoElectronico: json['correoElectronico'],
      fechaNacimiento: json['fechaNacimiento'],
      genero: json['genero'],
      estadoCivil: json['estadoCivil'],
      rfc: json['rfc'],
      curp: json['curp'],
      telefonoParticular: json['telefonoParticular'],
      telefonoMovil: json['telefonoMovil'],
      telefonoEmergencia: json['telefonoEmergencia'],
      nombreCompletoFamiliar: json['nombreCompletoFamiliar'],
      domicilio: json['domicilio'] != null ? DomicilioModel.fromJson(json['domicilio']) : null,
      datosMedicos: json['datosMedicos'] != null ? DatosMedicosModel.fromJson(json['datosMedicos']) : null,
      certificaciones: json['certificacionesExperiencia'] != null ? (json['certificacionesExperiencia'] as List).map((v) => CertificacionesModel.fromJson(v)).toList().obs : null, 
      avatarImage: json['avatarImage'],
      estatus: json['estatus'],
      documentacion: json['documentacion'] != null ? DocumentacionModel.fromJson(json['documentacion']) : null,
      fechaRegistro: DateTime(2021, 1, 1) //json['fechaRegistro'] != null ? DateTime.tryParse(json['fechaRegistro']) : ,
    );
  }

  /// Convierte una instancia de PersonaModel a un Map JSON.
  Map<String, dynamic> toJson() {
    return {
      'idPersona': idPersona,
      'nombre': nombre,
      'apellidoPaterno': apellidoPaterno,
      'apellidoMaterno': apellidoMaterno,
      'correoElectronico': correoElectronico,
      'fechaNacimiento': fechaNacimiento,
      'genero': genero,
      'estadoCivil': estadoCivil,
      'rfc': rfc,
      'curp': curp,
      'telefonoParticular': telefonoParticular,
      'telefonoMovil': telefonoMovil,
      'telefonoEmergencia': telefonoEmergencia,
      'nombreCompletoFamiliar': nombreCompletoFamiliar,
      'domicilio': domicilio?.toJson(),
      'datosMedicos': datosMedicos?.toJson(),
      'certificaciones': certificaciones?.map((e) => e.toJson()).toList(),
      'avatarImage': avatarImage,
      'estatus': estatus,
      'documentacion': documentacion?.toJson(),
      'fechaRegistro': fechaRegistro,
    };
  }
  // Crea un color de fondo para la persona
  static Future<Color> getColorBh(String image) async {
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(image));
    return paletteGenerator.dominantColor?.color ?? Colors.white;
  }
}
