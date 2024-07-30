import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/comentarios_model.dart';
import 'package:get/get.dart';

import 'persona_model.dart';

class UsuarioModel{

  int? idUsuario;
  EstatusModel? estatus;
  String? nivelUsuario;
  int? calificacion;
  String? usuario;
  String? contrasena;
  RxList<PersonaModel>? persona;
  RxList<ComentariosModel>? comentariosUsuario;
  double? salarioCuidador;
  int? cuidadosRealizados;

  UsuarioModel({
    this.idUsuario, 
    this.estatus, 
    this.usuario,
    this.contrasena, 
    this.persona, 
    this.nivelUsuario, 
    this.calificacion,
    this.comentariosUsuario,
    this.salarioCuidador,
    this.cuidadosRealizados
  });
    
  factory UsuarioModel.fromJson(Map<String, dynamic> json){
    return UsuarioModel(
      idUsuario: json['id_usuario'],
      estatus: json['estatus'],
      nivelUsuario: json['nivel_usuario'],
      calificacion: json['calificacion'],
      usuario: json['usuario'],
      contrasena: json['contrasena'],
      persona: json['persona'] != null ? (json['persona'] as List).map((v) => PersonaModel.fromJson(v)).toList().obs : null,
      comentariosUsuario: json['comentarios_usuario'] != null ? (json['comentarios_usuario'] as List).map((v) => ComentariosModel.fromJson(v)).toList().obs : null,
      salarioCuidador: json['salario_cuidador'].toDouble(),
      cuidadosRealizados: json['cuidados_realizados']
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_usuario'] = idUsuario;
    data['estatus'] = estatus;
    data['nivel_usuario'] = nivelUsuario;
    data['calificacion'] = calificacion;
    data['usuario'] = usuario;
    data['contrasena'] = contrasena;
    if(persona != null){
      data['persona'] = persona!.map((v) => v.toJson()).toList();
    }
    if(comentariosUsuario != null){
      data['comentarios_usuario'] = comentariosUsuario!.map((v) => v.toJson()).toList();
    }
    data['salario_cuidador'] = salarioCuidador;
    data['cuidados_realizados'] = cuidadosRealizados;
    return data;
  }

}