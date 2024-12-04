import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
// import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';

class ComentariosModel{

  int? idComentarios;
  PersonaModel? personaReceptor;
  PersonaModel? personaEmisor;
  int? calificacion;
  String? comentario;
  DateTime? fechaRegistro;

  ComentariosModel({this.idComentarios, this.personaReceptor, this.personaEmisor, this.calificacion, this.comentario, this.fechaRegistro});

  factory ComentariosModel.fromJson(Map<String, dynamic> json){
    return ComentariosModel(
      idComentarios: json['idComentarios'],
      personaReceptor: json['personaReceptor'] != null ? PersonaModel.fromJson(json['personaReceptor']) : null,
      personaEmisor: json['personaEmisor'] != null ? PersonaModel.fromJson(json['personaEmisor']) : null,
      calificacion: json['calificacion'],
      comentario: json['comentario'],
      fechaRegistro: json['fechaRegistro'] != null ? DateTime.tryParse(json['fechaRegistro']) : null
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idComentarios'] = idComentarios;
    data['personaReceptor'] = personaReceptor;
    data['personaEmisor'] = personaEmisor;
    data['calificacion'] = calificacion;
    data['comentario'] = comentario;
    data['fechaRegistro'] = fechaRegistro;
    return data;
  }

}