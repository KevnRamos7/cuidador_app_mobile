

import 'package:cuidador_app_mobile/Domain/Model/Perfiles/documentacion_model.dart';

class CertificacionesModel{

  int? idCertificacion;
  String? tipoCerficacion;
  String? institucionEmisora;
  String? fechaCerficacion;
  bool? vigente;
  int? experienciaAnios;
  String? descripcion;
  DocumentacionModel? documentacion;

  CertificacionesModel({this.idCertificacion, this.tipoCerficacion, this.institucionEmisora, this.fechaCerficacion, this.vigente, this.experienciaAnios, this.descripcion, this.documentacion});

  CertificacionesModel.fromJson(Map<String, dynamic> json){
    idCertificacion = json['id_certificacion'];
    tipoCerficacion = json['tipo_certificacion'];
    institucionEmisora = json['institucion_emisora'];
    fechaCerficacion = json['fecha_certificacion'];
    vigente = json['vigente'];
    experienciaAnios = json['experiencia_anios'];
    descripcion = json['descripcion'];
    documentacion = json['documentacion'] != null ? DocumentacionModel.fromJson(json['documentacion']) : null;
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_certificacion'] = idCertificacion;
    data['tipo_certificacion'] = tipoCerficacion;
    data['institucion_emisora'] = institucionEmisora;
    data['fecha_certificacion'] = fechaCerficacion;
    data['vigente'] = vigente;
    data['experiencia_anios'] = experienciaAnios;
    data['descripcion'] = descripcion;
    if(documentacion != null){
      data['documentacion'] = documentacion!.toJson();
    }
    return data;
  }

}