import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
// import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';

class ComentariosModel{

  int? idComentarios;
  PersonaModel? personaReceptor;
  PersonaModel? personaEmisor;
  int? calificacion;
  String? comentario;

  ComentariosModel({this.idComentarios, this.personaReceptor, this.personaEmisor, this.calificacion, this.comentario});

  factory ComentariosModel.fromJson(Map<String, dynamic> json){
    return ComentariosModel(
      idComentarios: json['id_comentarios'],
      personaReceptor: json['persona_receptor'],
      personaEmisor: json['persona_emisor'],
      calificacion: json['calificacion'],
      comentario: json['comentario'],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_comentarios'] = idComentarios;
    data['persona_receptor'] = personaReceptor;
    data['persona_emisor'] = personaEmisor;
    data['calificacion'] = calificacion;
    data['comentario'] = comentario;
    return data;
  }

}