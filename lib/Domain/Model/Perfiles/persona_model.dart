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
    // required this.colorBg,
    this.estatus,
    this.documentacion,
    this.fechaRegistro
  });

  /// Crea una instancia de PersonaModel a partir de un Map JSON.
  factory PersonaModel.fromJson(Map<String, dynamic> json) {
    return PersonaModel(
      idPersona: json['id_persona'],
      nombre: json['nombre'],
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      correoElectronico: json['correo_electronico'],
      fechaNacimiento: json['fecha_nacimiento'],
      genero: json['genero'],
      estadoCivil: json['estado_civil'],
      rfc: json['rfc'],
      curp: json['curp'],
      telefonoParticular: json['telefono_particular'],
      telefonoMovil: json['telefono_movil'],
      telefonoEmergencia: json['telefono_emergencia'],
      nombreCompletoFamiliar: json['nombre_completo_familiar'],
      domicilio: json['domicilio'] != null ? DomicilioModel.fromJson(json['domicilio']) : null,
      datosMedicos: json['datos_medicos'] != null ? DatosMedicosModel.fromJson(json['datos_medicos']) : null,
      certificaciones: json['certificaciones'] != null ? (json['certificaciones'] as List).map((v) => CertificacionesModel.fromJson(v)).toList().obs : null,
      avatarImage: json['avatar_image'],
      // colorBg: Colors.white,
      estatus: json['estatus'],
      documentacion: json['documentacion'] != null ? DocumentacionModel.fromJson(json['documentacion']) : null,
      // fechaRegistro:  json['fecha_resgistro'] != null ? DateTime.tryParse(json['fecha_registro']) : null,
      // colorBg: json['avatar_image'] != null ? getColorBh(json['avatar_image']) : Future.value(Colors.white),
    );
  }

  /// Convierte una instancia de PersonaModel a un Map JSON.
  Map<String, dynamic> toJson() {
    return {
      'id_persona': idPersona,
      'nombre': nombre,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'correo_electronico': correoElectronico,
      'fecha_nacimiento': fechaNacimiento,
      'genero': genero,
      'estado_civil': estadoCivil,
      'rfc': rfc,
      'curp': curp,
      'telefono_particular': telefonoParticular,
      'telefono_movil': telefonoMovil,
      'telefono_emergencia': telefonoEmergencia,
      'nombre_completo_familiar': nombreCompletoFamiliar,
      'domicilio': domicilio?.toJson(),
      'datos_medicos': datosMedicos?.toJson(),
      'certificaciones': certificaciones?.map((v) => v.toJson()).toList(),
      'avatar_image': avatarImage,
      'estatus': estatus,
      'documentacion': documentacion?.toJson(),
      'fecha_registro': fechaRegistro?.toIso8601String()
    };
  }

  // Crea un color de fondo para la persona
  static Future<Color> getColorBh(String image) async {
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(image));
    return paletteGenerator.dominantColor?.color ?? Colors.white;
  }
}
