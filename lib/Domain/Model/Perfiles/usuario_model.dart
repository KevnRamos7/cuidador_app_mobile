import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/comentarios_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/menu_model.dart';
import 'package:get/get.dart';

import 'persona_model.dart';

class UsuarioModel{

  int? idUsuario;
  EstatusModel? estatus;
  String? nivelUsuario;
  int? tipoUsuarioId;
  String? tipoUsuario;
  int? calificacion;
  String? usuario;
  String? contrasena;
  RxList<PersonaModel>? persona;
  RxList<ComentariosModel>? comentariosUsuario;
  List<MenuModel>? menus;
  double? salarioCuidador;
  int? cuidadosRealizados;

  UsuarioModel({
    this.idUsuario, 
    this.estatus, 
    this.usuario,
    this.contrasena, 
    this.persona, 
    this.nivelUsuario, 
    this.tipoUsuarioId,
    this.tipoUsuario,
    this.calificacion,
    this.comentariosUsuario,
    this.menus,
    this.salarioCuidador,
    this.cuidadosRealizados
  });
    
  factory UsuarioModel.fromJson(Map<String, dynamic> json){
    return UsuarioModel(
      idUsuario: json['idUsuario'],
      nivelUsuario: json['nivelUsuario'],
      tipoUsuarioId: json['tipoUsuarioid'],
      tipoUsuario: json['tipoUsuario'],
      calificacion: json['calificacion'],
      usuario: json['usuario1'],
      contrasena: json['contrasenia'],
      persona: json['personaFisica'] != null ? (json['personaFisica'] as List).map((v) => PersonaModel.fromJson(v)).toList().obs : null,
      comentariosUsuario: json['comentariosUsuarioPersonaReceptor'] != null ? (json['comentariosUsuarioPersonaReceptor'] as List).map((v) => ComentariosModel.fromJson(v)).toList().obs : null,
      menus: json['menu'] != null ? (json['menu'] as List).map((v) => MenuModel.fromJson(v)).toList() : null,
      salarioCuidador: 500, //double.tryParse(json['salarioCuidador']) ?? 0.0,
      cuidadosRealizados: json['cuidadosRealizados'] ?? 0
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUsuario'] = idUsuario;
    data['estatus'] = estatus;
    data['nivelUsuario'] = nivelUsuario;
    data['tipoUsuarioid'] = tipoUsuarioId;
    data['calificacion'] = calificacion;
    data['usuario'] = usuario;
    data['contrasena'] = contrasena;
    if(persona != null){
      data['persona'] = persona!.map((v) => v.toJson()).toList();
    }
    if(comentariosUsuario != null){
      data['comentariosUsuario'] = comentariosUsuario!.map((v) => v.toJson()).toList();
    }
    if(menus != null){
      data['menus'] = menus!.map((v) => v.toJson()).toList();
    }
    data['salarioCuidador'] = salarioCuidador;
    data['cuidadosRealizados'] = cuidadosRealizados;
    return data;
  }

}