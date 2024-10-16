

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
    idCertificacion = json['idCertificado'];
    tipoCerficacion = json['tipoCertificacion'];
    institucionEmisora = json['institucionEmisora'];
    fechaCerficacion = json['fechaCertificacion'];
    vigente = json['vigente'];
    experienciaAnios = json['experienciaAnios'];
    descripcion = json['descripcion'];
    documentacion = json['documentacion'] != null ? DocumentacionModel.fromJson(json['documentacion']) : null;
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCertificacion'] = idCertificacion;
    data['tipoCerficacion'] = tipoCerficacion;
    data['institucionEmisora'] = institucionEmisora;
    data['fechaCerficacion'] = fechaCerficacion;
    data['vigente'] = vigente;
    data['experienciaAnios'] = experienciaAnios;
    data['descripcion'] = descripcion;
    if(documentacion != null){
      data['documentacion'] = documentacion!.toJson();
    }
    return data;
  }

}